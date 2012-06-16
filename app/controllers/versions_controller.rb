class VersionsController < ApplicationController
  def destroy
    @extension = @business.extensions.find(params[:extension_id])
    if @extension.versions.count == 1
      flash[:error] = "You can't delete the only one version of this theme."
    else
      @extension.versions.find(params[:id]).destroy
      flash[:notice] = "Version deleted."
    end
    redirect_to send("#{@extension._type.downcase}_path", @extension)
  end
end
