package  {
	//genero la clase evento pez para personalizar mi evento pez
	import flash.events.Event;
	//clase que hereda de event
	public class EventoPez extends Event {

		public static const DESAPARECER_PEZ:String = "el pez desaparece";//es una constante porque queremos que  su valor sea igual en todo el programa y static esta disponible sin tener que hacer un objeto de esa clase
		public function EventoPez(type:String) {
			// constructor code
			super(type);//llama al constructor de la clase padre para que este me genere automaticamente el evento y le paso el type osea el string para que me pueda identificcar ese evento
		}

	}
	
}
