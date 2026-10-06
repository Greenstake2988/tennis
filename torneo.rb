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
  attr_reader :jugador1, :jugador2, :ganador, :puntos_en_juego

  def initialize(jugador1, jugador2, puntos_en_juego)
    @jugador1 = jugador1
    @jugador2 = jugador2
    @puntos_en_juego =  puntos_en_juego
    @ganador = nil
  end


  def registrar_ganador(jugador)
    @ganador = jugador
    perdedor = (jugador == @jugador1) ? @jugador2 : @jugador1

    jugador.sumar_puntos(@puntos_en_juego)

    "Terminó #{@jugador1.nombre} vs #{@jugador2.nombre}. " \
    "Ganador: #{jugador.nombre} (+#{@puntos_en_juego}), ahora tiene #{jugador.puntos}. " \

  end

  def to_s
    "#{jugador1.nombre} vs #{jugador2.nombre}"
  end
end


class Torneo
  attr_reader :nombre,:jugadores, :partidos

  def initialize(nombre)
    @nombre = nombre
    @jugadores = []
    @partidos = []
  end

  def agregar_jugador(jugador)
    @jugadores << jugador
  end


  def armar_partidos(puntos_por_partido)
    @partidos = []
    @jugadores.shuffle.each_slice(2) do |j1, j2|
      @partidos << Partido.new(j1, j2, puntos_por_partido)
    end
  end
end


jugador1 = Jugador.new("Oscar")
jugador2 = Jugador.new("Hector")

puts "El jugador de nombre #{jugador1.nombre} tiene #{jugador1.puntos}"
puts "Otro jugador se llama #{jugador2.nombre} tambien tiene #{jugador2.puntos}"


partido = Partido.new(jugador1, jugador2, 200)

puts "El partido uno es " + partido.to_s

torneo = Torneo.new("Torneo de Octubre")
torneo.agregar_jugador(jugador1)
torneo.agregar_jugador(jugador2)

torneo.armar_partidos(200)

partido = torneo.partidos.first
puts partido.registrar_ganador(partido.jugador1)
# puts jugador1.class
# p jugador1
