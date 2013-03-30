module Ecm
  module References
    class Routing
      def self.routes(router, options = {})
        options.reverse_merge!({})

        # router.resources :posts, :controller => 'ecm/references/posts'
      end
    end
  end
end

