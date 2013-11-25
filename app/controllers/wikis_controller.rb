class WikisController < ApplicationController
  def index
    @wikis = Wiki.order(:section, :name).all
  end
  
  def show
    @wiki = Wiki.where(:section => params[:section], :name => params[:name]).first
  end
  
  def new
    @wiki = Wiki.new
    
    @form_submit = I18n.t("messages.base.create_wiki_page")
  end
  
  def create
    @wiki = Wiki.new(params[:wiki])

    @res = @wiki.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to edit_wiki_path(@wiki), :notice => I18n.t("messages.base.record_created")
        else
          @errors = @wiki.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :wiki => @wiki
          }
        else
          render :json => {
            :state => false,
            :errors => @wiki.errors
          }
        end
      }
    end
  end
  
  def edit
    @wiki = Wiki.find(params[:id])
    
    @form_submit = I18n.t("messages.base.update_wiki_page")
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(params[:wiki]);

    @res = @wiki.save

    respond_to do |format|
      format.html {
        if @res
          redirect_back(I18n.t("messages.base.saved"), wikis_path)
#          redirect_to @player
        else
          @errors = @wiki.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :wiki => @wiki
          }
        else
          render json: {
            :result => false,
            :errors => @wiki.errors
          }
        end
      }
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    @res = @wiki.destroy

    respond_to do |format|
      format.html {
        redirect_back I18n.t("messages.base.wiki_page_deleted"), wikis_path
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
