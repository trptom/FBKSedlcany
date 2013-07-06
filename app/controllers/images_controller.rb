class ImagesController < ApplicationController
  def index
    if !params[:folder]
      params[:folder] = ""
    end

    @images = Image.where("logical_folder LIKE '#{params[:folder]}%'").all

    @folders = []
    @list = []

    if params[:folder] != ""
      @folders << {
        :name => "..",
        :folder => params[:folder].match(/.*\/.*/) ? params[:folder].gsub(/\/[^\/]*$/,"") : ""
      }
    end

    for image in @images
      if image.logical_folder == params[:folder]
        # pokud je obrazek primo ve slozce, pridam ho do vysledku
        @list << image
      else
        # pokud ve slozce neni, zjistim, jestli je v nejake jeji podslozce a tu
        # pripadne pridam do vysledku
        if params[:folder] == "" || image.logical_folder.match(/^#{params[:folder]}\//)
          name = image.logical_folder.gsub /^#{params[:folder]}\//, ""
          name = (name.split "/")[0]
          @folders << {
            :name => name,
            :folder => params[:folder] == "" ? name : "#{params[:folder]}/#{name}"
          }
        end
      end
    end

    @folders = @folders.uniq

    respond_to do |format|
      format.html {
        @new_image = Image.new
      }
      format.json {
        render :json => {
          :current_folder => params[:folder],
          :folders => @folders,
          :images => @images
        }
      }
    end
  end

  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html {}
      format.json {
        render :json => {
          :image => @image
        }
      }
    end
  end

  def create
    @image = Image.new(params[:image])
    @image.user = current_user

    @res = @image.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to images_path, folder: @image.logical_folder
        else
          @errors = @image.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :image => @image
          }
        else
          render :json => {
            :state => false,
            :errors => @image.errors
          }
        end
      }
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    @image.update_attributes(params[:image])
    @res = @image.save

    respond_to do |format|
      format.html {
        redirect_to @image
      }
      format.json {
        render json: {
          :result => @res,
          :image => @images
        }
      }
    end
  end

  def destroy
    @image = Image.find(params[:id])

    @folder = @image.logical_path
    @res = @image.destroy

    respond_to do |format|
      format.html {
        redirect_to images_path, folder: @folder
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
