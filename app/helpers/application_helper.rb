module ApplicationHelper
		include ActionView::Helpers::NumberHelper



    def get_random_product_image
    ['mom.jpg','meatballs.jpg','jam.jpg',
      'god.jpg','glasses.jpg','fry.jpg',
      'egg.jpg','cup.jpg','bacon.jpg',
      'axe3.jpg','axe2.jpg','axe1.jpg','5hr.jpg', 'bb.jpg', 'bfast.jpg',
      'flow.jpg','moustache.jpg','pancake.jpg','toothpaste.jpg', 'type.jpg'].sample
    end
end
