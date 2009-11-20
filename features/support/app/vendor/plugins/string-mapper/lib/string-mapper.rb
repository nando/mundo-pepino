#!/usr/bin/env ruby
# string-mapper.rb
#
# Copyright 2008, Fernando García Samblas <fernando.garcia at the-cocktail.com>
#
# See README and spec/string-mapper_spec for use details.
#
# string-mapper.rb is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 2.1 of the 
# License, or (at your option) any later version.
#
# string-mapper.rb is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with string-mapper in a file called COPYING; if not, 
# write to the Free Software Foundation, Inc., 51 Franklin St, Fifth 
# Floor, Boston, MA 02110-1301 USA
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
	
require 'active_support'

module StringMapper #:nodoc:
  class VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY  = 1
    PATCH = nil # Set to nil for official release

    STRING = [MAJOR, MINOR, TINY, PATCH].compact.join('.')
  end
end

class String
  def self.add_mapper(name, mappings = {}, &def_val_block)
    accessor = "#{name}_mappings"
    cattr_accessor(accessor)
    self.send accessor + '=', mappings
    define_method "to_#{name}" do
      mapping = nil
      String.send(accessor).each do |key, value|
        regexp = if key.is_a?(Regexp)
          key
        else
          Regexp.new(key.to_s, Regexp::IGNORECASE)
        end
        if self =~ regexp
          mapping = if value.is_a?(String)
            eval('"'+value+'"')
          elsif value.is_a?(Proc)
            value.call *$~.captures
          else
            value
          end
          break
        end
      end
      if mapping.nil?
        (def_val_block && def_val_block.call(self))
      else
        mapping 
      end
    end
  end
end
