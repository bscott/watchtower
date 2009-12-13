module Watchtower
  module Beam
    def self.poll(beam)
      results = []
      beam.new.results.each do |result|
        existing = BEAMS.find('unique' => result['unique']).first
        if !existing
          self.save(result)
          results << result
        end
      end
      results
    end

    def self.poll_all
      self.poll(Beam::HackerNews)
      self.poll(Beam::Twitter)
    end

    def self.save(object)
      BEAMS.insert(object.merge({ 'created_at' => Time.now}))
    end

    # Returns all Needles. Can be passed an options hash
    #   :sort  - An array of [ field, order ] pairs
    #   :limit - How many results to return
    def self.all(options = {})
      default_options = {
        :sort  => [['created_at', 'descending']],
        :limit => 100
      }

      BEAMS.find({}, default_options.merge(options))
    end
  end
end