module Slugifiable
  module InstanceMethods
    def slug
      self.name.downcase.gsub(" ","-")
    end

    def unique_slug?
      if !!self.class.find_by_slug(self.slug)
      else
        true
      end
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect{|obj| obj.slug == slug}
    end
  end
end
