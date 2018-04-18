class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :update]
  before_action :reverse_geocode_address, only: [:create]

  # GET /todos
  def index
    # TODO - this should accept lat and lng
    # and get libraries within 25 miles
    @libraries = Library.all
    json_response(@libraries)
  end

  # POST /todos
  def create
    # do not create if another
    # library exists within ~100 feet of the
    # passed in lat / lon
    # 100 feet is approximately 0.018 miles
    @nearby = Library.within(0.018, :origin => [params[:lat], params[:lon]])
    if @nearby.blank?
      merged = library_params.merge(reverse_geocode_address)
      @library = Library.create!(merged)
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

  def set_library
    @library = Library.find(params[:id])
  end

  private
  def reverse_geocode_address
    unless params[:lat].nil? or params[:lon].nil?
      @latlng = params[:lat] + "," + params[:lon]
      res=Geokit::Geocoders::GoogleGeocoder.reverse_geocode @latlng
      if !res.success
        json_response({ message: "Could not reverse geocode coordinates" }, :unprocessable_entity)
      else
        @address = {:address => res.street_address, :city => res.city, :state => res.state, :zip => res.zip}
        # puts @address.to_yaml
      end
    end
    
  end
end

