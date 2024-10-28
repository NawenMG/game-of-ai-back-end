begin
  require 'cassandra'

  # Configurazione del cluster Cassandra
  cluster = Cassandra.cluster(
    hosts: ['localhost'],  # Assicurati di usare l'indirizzo corretto
    port: 9042             # Porta di connessione
  )

  # Esempio di utilizzo della connessione
  session = cluster.connect('nome_del_tuo_keyspace')  # Sostituisci con il tuo keyspace
rescue LoadError => e
  Rails.logger.error "Cassandra non può essere caricato: #{e.message}"
rescue => e
  Rails.logger.error "Errore durante la connessione a Cassandra: #{e.message}"
end
