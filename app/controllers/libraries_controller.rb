class LibrariesController < ApplicationController
  before_action :set_todo, only: [:show, :update]

  # GET /todos
  def index
    # TODO - this should accept lat and lng
    # and get libraries within 25 miles
    @libraries = Library.all
    json_response(@libraries)
  end

  # POST /todos
  def create
    # TODO - will need to geocode here
    # do not create if another
    # library exists within ~100 feet of the
    # passed in lat / lon
    # 100 feet is approximately 0.018 miles
    @nearby = Library.within(0.018, :origin => [params[:lat], params[:lon]])
    if @nearby.blank?
      @library = Library.create!(library_params)
      json_response(@library, :created)
    else
      json_response({ message: "A similar library exists nearby" }, :unprocessable_entity)
    end
    
  end

  # GET /todos/:id
  def show
    json_response(@library)
  end

  # PUT /todos/:id
  def update
    # TODO - should only be able to update images
    @library.update(library_params)
    head :no_content
  end

  private

  def library_params
    # whitelist params
    # TODO - this will probably need to be different
    params.permit(:name, :lat, :lon)
  end

  def set_todo
    @library = Library.find(params[:id])
  end
end

