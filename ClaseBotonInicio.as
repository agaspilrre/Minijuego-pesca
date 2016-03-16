package  {
	//esta clase contiene los atributos y metodos de boton de inicio.
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ClaseBotonInicio extends MovieClip {
		
		//CONSTRUCTOR
		public function ClaseBotonInicio() {
			// constructor code
			this.buttonMode=true;// para que el objeto se sensible al raton y pueda lanzar eventos es indispensable poner esta condicion con este metodo hacemos que cuando el raton pase por encima del boton adquiera la imagen de la mano clikadora
			this.mouseChildren=false;//esto se pone por si el boton tuviera mas objetos dentro tambien podria interactuar con el raton y darnos problemas por ejemplo tapar el boton con lo que con este metodo lo solucionariamos
			
			//pongo escuchadores de eventos y cada cual llama a su funcion correcpondiente cuando se produce dicho evento
			this.addEventListener(MouseEvent.MOUSE_OVER,funcionover);//raton encima boton
			this.addEventListener(MouseEvent.MOUSE_DOWN,funciondown);//clicamos el boton raton hacia abajo
			this.addEventListener(MouseEvent.MOUSE_UP,funcionout);//cuando se levanta el boton izquierdo del raton boton vuelve a la normalidad
			this.addEventListener(MouseEvent.MOUSE_OUT,funcionout);//raton no se encuentra encima boton raton fuera
			
		}
		//METODOS
		//metodo que reproduce animacion del boton cuando hacemos click
		private function funciondown(me:MouseEvent):void{
			this.gotoAndStop("click");
		}
		//metodo que reproduce el frame de la animacion cuando el cursor del raton esta encima del boton
		private function funcionover(me:MouseEvent):void{
			this.gotoAndStop("over");
		}
		//metodo que reproduce el frame de la animacion cuando tenemos el cursor del raton fuera del boton
		private function funcionout(me:MouseEvent):void{
			this.gotoAndStop("normal");
		}
	
	}
	
}
