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


module Marcador
  MINIMOS = {
    normal:         4,
    muerte_a_7:     7,
    muerte_a_10:   10
  }.freeze

  def self.valido?(a, b, tipo, con_ventajas)
    minimo   = MINIMOS.fetch(tipo)
    ganador  = [a, b].max
    perdedor = [a, b].min
    diferencia = ganador - perdedor

    return false if perdedor < 0 || ganador < minimo

    if con_ventajas
      # El ganador llegó justo al mínimo: basta con ganar por 2 o más
      return diferencia >= 2 if ganador == minimo
      diferencia == 2
    else
      ganador == minimo && perdedor < minimo
    end
  end
end

class Partido
  #private_class_method :new
  attr_reader :jugador1, :jugador2, :ganador, :puntos_en_juego, :tipo_de_partido, :marcadores, :con_ventajas

  TIPOS_DE_PARTIDOS = %i[muerte_a_10 muerte_a_7 normal].freeze
  VALORES = {
    :normal => 4,
    :muerte_a_7 => 7,
    :muerte_a_10 => 10
   }.freeze

  NOMBRES_DE_TIPOS = {
    muerte_a_10: "muerte súbita a 10",
    muerte_a_7: "muerte súbita a 7",
    normal: "a 4 games"
  }.freeze

  def initialize(jugador1, jugador2, puntos_en_juego, tipo_de_partido, con_ventajas)
    [jugador1, jugador1].each do |j|
      raise ArgumentError, "se esperaba un Jugador, llego #{j.class}" unless j.is_a?(Jugador)
    end
    raise ArgumentError, "tipo de partido inválido: #{tipo_de_partido}" unless TIPOS_DE_PARTIDOS.include?(tipo_de_partido)

    @jugador1 = jugador1
    @jugador2 = jugador2
    @puntos_en_juego =  puntos_en_juego
    @tipo_de_partido = tipo_de_partido
    @ganador = nil
    @marcadores = []
  end



  def registrar_marcador(a, b)
    @marcadores << Marcador.new(a, b ,VALORES.fetch(@tipo_de_partido), @con_ventajas)
    @marcadores.first.gana_jugador_1? ?  registrar_ganador(@jugador1) : registrar_ganador(@jugador2)

  end

  def to_s
    "#{jugador1.nombre} vs #{jugador2.nombre}"
  end

  private

  def registrar_ganador(jugador)
    @ganador = jugador
    perdedor = (jugador == @jugador1) ? @jugador2 : @jugador1

    jugador.sumar_puntos(@puntos_en_juego)

    "Terminó #{@jugador1.nombre} vs #{@jugador2.nombre} jugaron #{NOMBRES_DE_TIPOS[@tipo_de_partido]}. " \
    "Ganador: #{jugador.nombre} (+#{@puntos_en_juego}), ahora tiene #{jugador.puntos}. "

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


  def armar_partidos(tipo_de_partido, con_ventajas)
    @partidos = []
    @jugadores.shuffle.each_slice(2) do |j1, j2|
      @partidos << Partido.new(j1, j2,  @puntos_prueba, tipo_de_partido, con_ventajas)
    end
  end
end


# Tests

# jugador1 = Jugador.new("Oscar")
# jugador2 = Jugador.new("Hector")
#
# puts "El jugador de nombre #{jugador1.nombre} tiene #{jugador1.puntos}"
# puts "Otro jugador se llama #{jugador2.nombre} tambien tiene #{jugador2.puntos}"
#
#
# partido = Partido.new(jugador1, jugador2, 200, :normal, true)
#
# puts "El partido uno es " + partido.to_s
#
# torneo = Torneo.new("Torneo de Octubre", 200)
# torneo.agregar_jugador(jugador1)
# torneo.agregar_jugador(jugador2)
#
# torneo.armar_partidos(:normal, true)
#
# partido = torneo.partidos.first
# puts partido.registrar_marcador(4,0)

#partido.registrar_marcador(10,5)
# puts jugador1.class
# p jugador1
