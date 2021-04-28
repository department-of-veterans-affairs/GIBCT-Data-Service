module InstitutionBuilder
  class ScorecardBuilder
    def self.add_scorecard(version_id)
      str = <<-SQL
      UPDATE institutions SET #{columns_for_update(Scorecard)}, ialias = scorecards.alias
      FROM scorecards
      WHERE institutions.cross = scorecards.cross
      AND institutions.version_id = #{version_id}
      SQL

      Institution.connection.update(str)
    end

    def self.update_lat_lon_from_scorecard(version_id)
      str = <<-SQL
      UPDATE institutions SET latitude = scorecards.latitude, longitude = scorecards.longitude
      FROM scorecards
      WHERE institutions.cross = scorecards.cross
      AND institutions.version_id = #{version_id}
      AND institutions.latitude is NULL
      SQL

      Institution.connection.update(str)
    end
  end
end