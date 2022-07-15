class DogsController < ApplicationController
  
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: :edit

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index


  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = policy_scope(Dog).reverse
    @dogs = Dog.paginate(page: params[:page], per_page: 5)
  end


  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = current_user.dogs.new
    authorize @dog
  end

  # GET /dogs/1/edit
  def edit
    # @dog = current_user.dogs.find(params[:id])
    @dog = Dog.find(params[:id])
   
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = current_user.dogs.create(dog_params)
    authorize @dog

    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dog
    @dog = Dog.find(params[:id])
    authorize @dog
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dog_params
    params.require(:dog).permit(:name, :description, images: [])
  end
  # def require_permission
  #   if current_user != Dog.find(params[:id]).user
  #     redirect_to root_path
  #     #Or do something else here
  #   end
  # end
end
