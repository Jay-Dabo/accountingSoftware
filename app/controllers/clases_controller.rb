class ClasesController < ApplicationController
  before_action :set_clase, only: [:show, :edit, :update, :destroy]

  # GET /clases
  # GET /clases.json
  def index
    @clases = Clase.all
    respond_to do | format |
      format.html
      format.xlsx
    end
  end

  def import
    Clase.import(params[:file])
    redirect_to clases_path, notice:  "Clases imported"
  end

  # GET /clases/1
  # GET /clases/1.json
  def show
    @grupos =@clase.grupos
  end

  # GET /clases/new
  def new
    @clase = Clase.new
  end

  # GET /clases/1/edit
  def edit
  end

  # POST /clases
  # POST /clases.json
  def create
    @clase = Clase.new(clase_params)

    respond_to do |format|
      if @clase.save

        format.html { redirect_to @clase, flash: {success:  "Clase #{@clase.name} fue creada exitosamente."  } }
        format.json { render :show, status: :created, location: @clase }
      else
        format.html { render :new }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clases/1
  # PATCH/PUT /clases/1.json
  def update
    respond_to do |format|
      if @clase.update(clase_params)
        format.html { redirect_to clases_path, flash: {success:  "Clase #{@clase.name} fue actualizada exitosamente."  } }
        format.json { render :show, status: :ok, location: @clase }
      else
        format.html { render :edit }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clases/1
  # DELETE /clases/1.json
  def destroy
    @clase.destroy
    respond_to do |format|
      format.html { redirect_to clases_url, flash: {warning:  "Clase #{@clase.name} fue eliminada exitosamente."  } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clase
      @clase = Clase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clase_params
      params.require(:clase).permit(:number, :name)
    end
end
