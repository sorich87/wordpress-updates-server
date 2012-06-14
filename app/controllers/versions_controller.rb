class VersionsController < ApplicationController
  def destroy
    @theme = @business.themes.find(params[:theme_id])
    if @theme.versions.count == 1
      flash[:error] = "You can't delete the only one version of this theme."
    else
      @version = @theme.versions.destroy_all(id: params[:id])
      flash[:notice] = "Version deleted."
    end
    redirect_to theme_path(@theme)
  end
end
