class Shift
  module GetDateTime
    class << self
      def call(date, time)
        DateTime.parse("#{date} #{time}")
      end
    end
  end
end
