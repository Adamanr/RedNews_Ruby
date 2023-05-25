class EditionsController < ApplicationController
  before_action :set_edition, only: %i[ show edit update destroy ]

  # GET /editions or /editions.json
  def index
    @editions = Edition.where(verified:true)
  end

  def subscribe
    @e = EditionSubscription.new(user_id: params[:user_id], edition_id: params[:edition_id])
    if @e.save
      if @e.user.id != @e.edition.user_id
        @e_role = EditionUser.new(user_id: params[:user_id], edition_id: params[:edition_id],role_id:4)
        @e_role.save
      end
      render json: @e
    else
      render json: @e, status: 500
    end
  end

  def unsubscribe
    @e = EditionSubscription.find_by(user_id: params[:user_id], edition_id: params[:edition_id])
    @e.delete
    if @e.save
      render json: @e
    else
      render json: @e, status: 500
    end
  end

  def user_list
    @users_list = EditionUser.where(edition_id: params[:id])
  end

  # GET /editions/1 or /editions/1.json
  def show
    @edition_news_count = Event.where(edition_id: params[:id]).count
    @subscribe = EditionSubscription.find_by(user_id: current_user.id, edition_id:params[:id])
  end

  def posts
    @edition = Edition.find(params[:id])

    @events = Event.where(edition_id: params[:id])
    @eiditon_name = @edition.name

    @edition_news_count = Event.where(edition_id: params[:id]).count
    @subscribe = EditionSubscription.find_by(user_id: current_user.id, edition_id:params[:id])
  end

  # GET /editions/new
  def new
    @edition = Edition.new
  end

  # GET /editions/1/edit
  def edit
  end

  # POST /editions or /editions.json
  def create
    @edition = Edition.new(edition_params)
    @edition.user_id = current_user.id
    @edition.verified = false
    respond_to do |format|
      if @edition.save
        format.html { redirect_to edition_url(@edition), notice: "Edition was successfully created." }
        format.json { render :show, status: :created, location: @edition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editions/1 or /editions/1.json
  def update
    respond_to do |format|
      if @edition.update(edition_params)
        format.html { redirect_to edition_url(@edition), notice: "Edition was successfully updated." }
        format.json { render :show, status: :ok, location: @edition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editions/1 or /editions/1.json
  def destroy
    @edition.destroy

    respond_to do |format|
      format.html { redirect_to editions_url, notice: "Edition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edition
      @edition = Edition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def edition_params
      params.require(:edition).permit(:name, :desc, :url, :user_id, :category, :logo, :color)
    end
end
