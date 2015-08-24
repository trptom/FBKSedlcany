class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def new
    @survey = Survey.new

    @form_title = I18n.t("messages.surveys.new.title");
    @form_submit = I18n.t("messages.surveys.new.create");
  end

  def create
    @survey = Survey.new(params[:survey])
    @res = @survey.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @survey
        else
          @errors = @survey.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :survey => @survey
          }
        else
          render :json => {
            :state => false,
            :errors => @survey.errors
          }
        end
      }
    end
  end

  def edit
    @survey = Survey.find(params[:id])

    @form_title = I18n.t("messages.surveys.edit.title");
    @form_submit = I18n.t("messages.surveys.edit.update");
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes(params[:survey]);
    @res = @survey.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @survey
        else
          @errors = @survey.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :survey => @survey
          }
        else
          render json: {
            :result => false,
            :errors => @survey.errors
          }
        end
      }
    end
  end

  def destroy
    @survey = Hall.find(params[:id])

    @res = @survey.destroy

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
