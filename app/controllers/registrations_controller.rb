class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        # Устанавливаем стандартную аватарку, если пользователь успешно создан
        resource.avatar.attach(io: File.open('./app/assets/images/default.jpg'), filename: 'default_avatar.jpg', content_type: 'image/jpg')
      end
      resource.user_role_id = 1 # Установка значения role_id (например, 4)
      resource.avatar.attach(io: File.open('./app/assets/images/default.jpg'), filename: 'default_avatar.jpg', content_type: 'image/jpg')
      resource.save
    end
  end

  protected
  def after_update_path_for(resource)
    users_path(resource) # Здесь user_path замените на путь к методу show, соответствующий вашей реализации
  end
end
