module Denko
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.gil?
    ["mruby", "ruby"].include? RUBY_ENGINE
  end

  def self.mruby?
    RUBY_ENGINE == "mruby"
  end
end
