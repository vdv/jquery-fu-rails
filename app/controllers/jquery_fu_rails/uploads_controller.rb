class JqueryFuRails::UploadsController < ApplicationController
  def index
    @files = JqueryFuRails::Attachment.all
    render json: @files.map{|f| f.to_jqueryfu}
  end

  def create
    @file = JqueryFuRails::Attachment.new(params[:upload])

    respond_to do |format|
      if @file.save
        format.html {
          render json: [@file.to_jqueryfu],
                 content_type: 'text/html',
                 layout: false
        }
        format.json { render json: { files: [@file.to_jqueryfu] }, status: :created, location: @file }
      else
        format.html { render action: "new" }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
    # file = params[:qqfile]
    # if params[:assetable_id] && asset_obj = (params[:assetable_type].constantize rescue nil)
    #   asset_obj = asset_obj.find(params[:assetable_id])
    #   @asset.assetable = asset_obj if asset_obj
    # end
    # @asset.data = FuploadRails::Http.normalize_param(file, request)

    # if @asset.save
    #   render :json => {:success => true}#{ :filelink => @asset.url }.to_json
    # else
    #   render :json => {:error => @asset.errors.full_messages.join('. ')}
    # end
  end

  def destroy
    JqueryFuRails::Attachment.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { head :no_content }
    end

  end
end

