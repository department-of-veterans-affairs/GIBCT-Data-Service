# frozen_string_literal: true

module Common::Client
  module Monitoring
    extend ActiveSupport::Concern

    def with_monitoring(trace_location = 1)
      caller = caller_locations(trace_location, 1)[0].label
      yield
    rescue StandardError => e
      increment_failure(caller, e)
      raise e
    ensure
      increment_total(caller)
    end

    private

    def increment_total(caller)
      increment("#{self.class::STATSD_KEY_PREFIX}.#{caller}.total")
    end

    def increment_failure(caller, error)
      tags = ["error:#{error.class}"]
      tags << "status:#{error.status}" if error.try(:status)

      increment("#{self.class::STATSD_KEY_PREFIX}.#{caller}.fail", tags)
    end

    def increment(key, tags = nil)
      StatsDMetric.new(key: key).save
      if tags.blank?
        StatsD.increment(key)
      else
        StatsD.increment(key, tags: tags)
      end
    end
  end
end
