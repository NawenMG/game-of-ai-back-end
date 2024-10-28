class MyChannel < ApplicationCable::Channel
  def subscribed
    # Inizializzazione quando il client si connette
    stream_from "my_channel"
  end

  def unsubscribed
    # Cleanup quando il client si disconnette
    # Ad esempio: rimuovi il client da un gruppo
    stop_streaming_from "my_channel"
  end
end
