module Workflows
  class AlbumWorkflow
    attr_reader :form, :params

    def initialize(form, params)
      @form = form
      @params = params
    end

    def process
      if form.validate(params)
        if form.save
          yield form.model if block_given?
        end
      end
    end

  end
end
