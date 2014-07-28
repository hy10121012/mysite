class BlogsController < ApplicationController
  protect_from_forgery :except => :create

  DATETIME_FORMAT = "%Y%m%d%H%M";

  def index
  end
  def new
  end
  def find_by_offset
    offset = params[:offset];
    if offset.nil?
      offset=0;
    end
    @blogs = Blog.all.limit(10).offset(offset).order("created_at desc");
    @blogs.each  do | blog|
      blog.content = blog.content.truncate(20);
      puts "---------->"+blog.content
    end
    render json: @blogs.to_json(include: :tags);
  end

  def show
    @article = Blog.find(params[:id]);
  end

  def get_comment
    @comments = Comment.where("blog_id"=>params[:id]).order("created_at desc");
    if params[:mode].nil?
      @comments.limit(2)
    end
    render json: @comments
  end

  def add_comment
    if !params[:comment].length>0 & !params[:name].length>0
      comment = Comment.new;
      comment.content=params[:comment]
      comment.name=params[:name]
      comment.blog_id=params[:id];
      comment.save
    end
    get_comment()
  end

  def create
    content = params[:blog][:content];
    title = params[:blog][:title];
    imgs = params[:blog][:imgs];
    tags = params[:tags];

    if !imgs.nil?
      imgs.each_with_index do |img,index|
        img_aligs =Time.now.strftime(DATETIME_FORMAT).to_s+img[:key];
        content.gsub(img[:key],"<img src='"+img_aligs+"' class='blog_img' />")
      end
    end
    tag_array = Array.new;
    puts tags

    if !tags.nil?
      tags.each_with_index do  |tag,index|
        if  tag.length > 0
          got_tag = Tag.find_by_name(tag);
          if got_tag.nil?
            got_tag = Tag.new
            got_tag.name = tag;
            got_tag.created_at = Time.now.strftime(DATETIME_FORMAT);
            got_tag.save;
          end
          tag_array[index] = got_tag
        end
      end
    end

    blog_raw = upload_params
    blog_raw[:title]= title
    blog_raw[:content]= content
    blog_raw[:tags]= tag_array
    blog = Blog.create(blog_raw);
    blog.created_at = Time.now.strftime(DATETIME_FORMAT);
    blog.updated_at = Time.now.strftime(DATETIME_FORMAT);
    blog.save;
    redirect_to("/my_blog")
  end

  def upload_params
    params[:blog].permit(:cover)
  end

end
