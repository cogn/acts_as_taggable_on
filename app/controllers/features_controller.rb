class FeaturesController < ApplicationController

	def straight_usage
		@user = User.new(:name => "Bobby")
		@user.tag_list = "awesome, slick, hefty"      # this should be familiar
		@user.skill_list = "joking, clowning, boxing" # but you can do it for any context!		
		@user.save		

		logger.info"********#{@user.tags.inspect}**********"
		logger.info"********#{@user.skills.inspect}**********"
		render :nothing => true
	end	

	def preserve_order
		# To preserve the order in which tags are created use acts_as_ordered_taggable:	
		@user = User.new(:name => "Bobby2")
		@user.tag_list = "east, south"
		@user.save

		logger.info"********#{@user.tags.inspect}**********"

		@user.tag_list = "north, east, south, west"
		@user.save

		@user.reload
		# after reloading the order was preserved!
		logger.info"********#{@user.tags.inspect}**********"
		render :nothing => true
	end	

	def relationships
		@user = User.new(:name => "Bobby3")
		@user.skill_list = "joking, diving"
		@user.save

		@user = User.new(:name => "Frankie")
		@user.skill_list = "hacking"
		@user.save
		
		@user = User.new(:name => "Tom")
		@user.skill_list = "hacking,jogging,diving"
		@user.save		

		@tom = User.find_by_name("Tom")	
		logger.info"*******************************************************************"
		logger.info"*******#{@tom.find_related_skills.inspect}*************************"
		logger.info"*******************************************************************"
		render :nothing => true
	end	

	def dynamic_tags
		@user = User.new(:name => "Bobby4")
		@user.set_tag_list_on(:customs, "same, as, tag, list")
		@user.tag_list_on(:customs) # => ["same","as","tag","list"]
		@user.save

		logger.info"**********#{@user.tags_on(:customs).inspect}***************"
		logger.info"*********#{@user.tag_counts_on(:customs)}******************"
		logger.info"*************#{User.tagged_with("same", :on => :customs).inspect}************"	
		render :nothing => true	
	end	

	def dirty_objects		
		@bobby = User.find_by_name("Bobby")
		
		logger.info"***********#{@bobby.skills.inspect}**************" #@boddy.skill_list_changed? #=> false
		# below line should work but not.
		#logger.info"***********#{@bobby..changes}**************"
	end	
end
