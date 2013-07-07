# coding:utf-8

class CreateDefaultLeagues < ActiveRecord::Migration
  def self.up
    def add_league(name, shortname, shortcut, level, group)
      league = League.new(
        :name => name,
        :short_name => shortname,
        :shortcut => shortcut,
        :level => level,
        :group => group
      )
      league.save
    end

    add_league("PH+SČ liga mužů divize A", "Liga mužů, sk. A", "3XM5-A", 7, 1)
    add_league("PH+SČ liga mužů divize B", "Liga mužů, sk. B", "3XM5-B", 7, 2)

    add_league("PH+SČ přebor mužů divize A", "Přebor mužů, sk. A", "3XM6-A", 7, 1)
    add_league("PH+SČ přebor mužů divize B", "Přebor mužů, sk. B", "3XM6-B", 7, 2)
    add_league("PH+SČ přebor mužů divize C", "Přebor mužů, sk. C", "3XM6-C", 7, 3)
    add_league("PH+SČ přebor mužů divize D", "Přebor mužů, sk. D", "3XM6-D", 7, 4)

    add_league("PH+SČ soutěž mužů divize A", "Soutěž mužů, sk. A", "3XM7-A", 7, 1)
    add_league("PH+SČ soutěž mužů divize B", "Soutěž mužů, sk. B", "3XM7-B", 7, 2)
    add_league("PH+SČ soutěž mužů divize C", "Soutěž mužů, sk. C", "3XM7-C", 7, 3)
    add_league("PH+SČ soutěž mužů divize D", "Soutěž mužů, sk. D", "3XM7-D", 7, 4)
    add_league("PH+SČ soutěž mužů divize E", "Soutěž mužů, sk. E", "3XM7-E", 7, 5)
    add_league("PH+SČ soutěž mužů divize F", "Soutěž mužů, sk. F", "3XM7-F", 7, 6)
  end

  def self.down
    League.delete_all
  end
end
