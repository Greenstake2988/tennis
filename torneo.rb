class Jugador
  attr_reader :nombre, :puntos

  def initialize(nombre)
    @nombre = nombre
    @puntos = 0
  end

  def sumar_puntos(puntos)
    @puntos += puntos
  end
end

class Partido
  attr_reader :jugador1, :jugador2, :ganador, :puntos_en_juego, :tipo_de_partido
  TIPOS_DE_PARTIDOS = %i[muerte_a_10 muerte_a_7 a_4_games].freeze
  NOMBRES_DE_TIPOS = {
    muerte_a_10: "muerte súbita a 100",
    muerte_a_7: "muerte súbita a 7",
    a_4_games: "a 4 games"
  }.freeze

  def initialize(jugador1, jugador2, puntos_en_juego, tipo_de_partido)
    raise ArgumentError, "tipo de partido inválido: #{tipo_de_partido}" unless TIPOS_DE_PARTIDOS.include?(tipo_de_partido)

    @jugador1 = jugador1
    @jugador2 = jugador2
    @puntos_en_juego =  puntos_en_juego
    @tipo_de_partido = tipo_de_partido
    @ganador = nil
  end

  def registrar_ganador(jugador)
    @ganador = jugador
    perdedor = (jugador == @jugador1) ? @jugador2 : @jugador1

    jugador.sumar_puntos(@puntos_en_juego)

    "Terminó #{@jugador1.nombre} vs #{@jugador2.nombre} jugaron #{NOMBRES_DE_TIPOS[@tipo_de_partido]}. " \
    "Ganador: #{jugador.nombre} (+#{@puntos_en_juego}), ahora tiene #{jugador.puntos}. "

  end

  def to_s
    "#{jugador1.nombre} vs #{jugador2.nombre}"
  end
end

class Marcador
  attr_reader :tipo, :resultado,

  def initialize(tipo)
    @tipo = tipo
  end
end

class Torneo
  attr_reader :nombre,:jugadores, :partidos, :puntos_prueba

  def initialize(nombre, puntos_prueba)
    @puntos_prueba = puntos_prueba
    @nombre = nombre
    @jugadores = []
    @partidos = []
  end

  def agregar_jugador(jugador)
    @jugadores << jugador
  end


  def armar_partidos(tipo_de_partido)
    @partidos = []
    @jugadores.shuffle.each_slice(2) do |j1, j2|
      @partidos << Partido.new(j1, j2,  @puntos_prueba, tipo_de_partido,)
    end
  end
end


# Tests

jugador1 = Jugador.new("Oscar")
jugador2 = Jugador.new("Hector")

puts "El jugador de nombre #{jugador1.nombre} tiene #{jugador1.puntos}"
puts "Otro jugador se llama #{jugador2.nombre} tambien tiene #{jugador2.puntos}"


partido = Partido.new(jugador1, jugador2, 200, :a_4_games)

puts "El partido uno es " + partido.to_s

torneo = Torneo.new("Torneo de Octubre", 200)
torneo.agregar_jugador(jugador1)
torneo.agregar_jugador(jugador2)

torneo.armar_partidos(:a_4_games)

partido = torneo.partidos.first
puts partido.registrar_ganador(partido.jugador1)
# puts jugador1.class
# p jugador1
