class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @all_entries = Entry.all
    @max_pages = @all_entries.max_pages
    @recent = @all_entries.page

    if page_params[:page]

      if page_params[:page].to_i > @max_pages.to_i or page_params[:page].to_i < 1
        redirect_to root_url, notice: 'Page does not exist. Only 1 through ' + @max_pages.to_s + ' pages exist.'
      end

      @entries = @all_entries.page(page_params[:page].to_i)
      @current_page = page_params[:page]
    else
      @entries = @all_entries.page
      @current_page = 1
    end

  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @recent = Entry.page
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id

    respond_to do |format|
      if @entry.save
        format.html { redirect_to root_url, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to root_url, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:user_id, :title, :body, :slug)
    end

    def page_params
      params.permit(:page)
    end
end
