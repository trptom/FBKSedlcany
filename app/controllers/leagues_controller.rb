class LeaguesController < ApplicationController
  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = League.new

    @form_title = I18n.t("messages.halls.new.title");
    @form_submit = I18n.t("messages.halls.new.create");
  end

  def create
    @league = League.new(params[:league])
    @res = @league.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @league
        else
          @errors = @league.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :league => @league
          }
        else
          render :json => {
            :state => false,
            :errors => @league.errors
          }
        end
      }
    end
  end

  def edit
    @league = League.find(params[:id])

    @form_title = I18n.t("messages.halls.edit.title");
    @form_submit = I18n.t("messages.halls.edit.update");
  end

  def update
    @league = League.find(params[:id])
    @league.update_attributes(params[:league]);
    @res = @league.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @league
        else
          @errors = @league.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :league => @league
          }
        else
          render json: {
            :result => false,
            :errors => @league.errors
          }
        end
      }
    end
  end

  def destroy
    @league = League.find(params[:id])

    @res = @league.destroy

    respond_to do |format|
      format.html {
        redirect_to :back
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
