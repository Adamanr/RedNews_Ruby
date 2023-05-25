module AdminHelper
  def likes_a(ups)
    likes = Like.where(likeable_id:ups, likeable_type: "Article").count
    return likes
  end

  def likes_e(ups)
    likes = Like.where(likeable_id:ups, likeable_type: "Event").count
    return likes
  end

  def user_post_count(id)
    post_count = Event.where(user_id:id) + Article.where(user_id:id)
    return post_count.count
  end
end
