module Watchtower
  module Views
    class Index < Mustache
      include Watchtower::Helpers

      def beams
        format_beams(Beam.all)
      end
    end
  end
end
