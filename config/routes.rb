Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :cars, only: %w[index show new create] do
    resources :bookings, only: %w[create]
  end
  resources :bookings, only: %w[index]
  patch '/booking/:id/accept', to: 'bookings#acceptBooking', as: :accept_booking
  patch '/booking/:id/reject', to: 'bookings#rejectBooking', as: :reject_booking
  get 'my_cars', to: 'cars#my_cars'

  resources :bookings do
    collection do
      get 'accepted'
      get 'rejected'
    end
  end
end
