package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import EventoPez; // ya que en esta clase tenemos al lanzador de eventos
	
	
	
	
	public class ClasePez extends MovieClip {
		
		private var stagePrincipal:Stage;
        //private var direccion:int=1;//1 a la derecha -1 izquierda cuando este valor se lo sumo a la x
		//private var espacio:int=10;
		private var tempx:Timer;
		//private var direcciony:int=1;//tengo que crear una direccion para y tambien
		//private var tempy:Timer;
		private var tweenHorizontal:Tween;
		private var tweenVertical:Tween;
		//private var sube:int;//si sube == 1; si baja == 2
		
		//CONSTRUCTOR
		public function ClasePez(_stagePrincipal:Stage) {
			// constructor code
			var distanciaSaltoHorizontal:int;//creo variables que voy a usar para el movimiento del pez
			var inicioX:int;
			var finX:int;
			
			this.stagePrincipal=_stagePrincipal;//igualo el stage que le paso como parametro al stage de la clase
			
			distanciaSaltoHorizontal = this.stagePrincipal.stageWidth - 40; // le decimos q la distancia de salto horizontal es la anchura del stage -40 20 por cada lado es la medida de longitud de salto
			
			inicioX = this.x = Math.random()*this.stagePrincipal.stageWidth;//el inicio del salto le metemos un ramdom para y multiplicamos por el ancho de la pantalla para que la coordenada x se genere en ese ancho
			this.y = this.stagePrincipal.stageHeight;//la y ponemos  la altura de la pantalla
			
			
			//DIRECCION DEL PEZ
			//si la x se genera despues de la mitad de la anchura de la pantalla va hacia la izquierda
			if(inicioX>this.stagePrincipal.stageWidth/2){//izquierda
				finX = inicioX - distanciaSaltoHorizontal;//eje x a la izquierda es negativo por eso resta y a la dcha es positivo por eso suma
			}else{//derecha
				finX = inicioX + distanciaSaltoHorizontal;
			}
			this.tweenHorizontal=new Tween(this,"x",None.easeIn,inicioX,finX,2,true);//creo objeto de tipo twin primer parametro refiero objeto clasepez con this coordenada x none.easein es el movimiento que le da el twin donde empieza el twin donde termina
			this.tweenHorizontal.addEventListener(TweenEvent.MOTION_FINISH,this.lanzarMensajeDesaparecerPez,false,0,true);//esta pendiente del twin y llama a la funcion desaparecer pez la funcion desaparecer pez manda el evento desaparecer pez y en la clase principal tenemos un escuchador pendiente de ese evento
			this.tweenHorizontal.start();//inicio el twin
			
			//MOTION Finish lanza el mensaje cuando termina la interpolacion.
			
			

			//None: se mueve de un lugar a otro
			//easein: parte lento
			//Regular:se muevve
			//easeout:terminalento
			
			
			this.tweenVertical=new Tween(this,"y",Regular.easeOut,this.y,100,1,true);
			//objeto al q se aplica la interpolacion,interpolar la posicion horizontaly,funcion que implementa mov o aceleracion,valor donde empieza,valor donde termina,duracion en segundos o fotogramas,tru si la duracion son segundos false si la duracion es en fotogramas
			this.tweenVertical.addEventListener(TweenEvent.MOTION_FINISH,this.darLaVuelta,false,0,true);
			this.tweenVertical.start();
			
			
		}
		
		//METODOS
		
		//esta funcion ejeccuta el movimiento del pez nos crea el pez dentro de la pantalla
		/*
		private function Moverx(te:TimerEvent):void{
			
			//comprueba que el pez no se salga a la izquierda o dcha si lo hace cambia de direccion y si no lo hace se mueve en el eje x
			if(this.x+espacio*direccion<=0+this.width/2 || this.x +espacio*direccion>= this.stagePrincipal.stageWidth-this.width/2){
			//cero es el limite izquierdo del ancho de pantalla stagewidth es limite drecho
			 direccion*=-1;//con esto cambia la direccion
			 //-1*1 q vale la direccion cambia a -1
			 //va a la otra direccion y cuando llega al tope -1*-1 es 1 y cambia de direccion
			}
			
			else
				this.x +=espacio*direccion;
				//y con esto comprobamos que no salga de la altura si lo hace cambia de direccion y si no lo hace se mueve en el eje Y
				if(this.y+espacio*direcciony<=0+this.height/2 || this.y +espacio*direcciony>= this.stagePrincipal.stageHeight-this.height/2){
			//cero es el limite izquierdo del ancho de pantalla stagewidth es limite drecho
			 direcciony*=-1;//con esto cambia la direccion
			 //-1*1 q vale la direccion cambia a -1
			 //va a la otra direccion y cuando llega al tope -1*-1 es 1 y cambia de direccion
			}
			
			else
				this.y +=espacio*direcciony;
			
		}
		*/
		//esta funcion hace que cuando los peces llegan a la altura establecida le hace el movimiento para que caigan invierte el twin
		private function darLaVuelta(te:TweenEvent):void{
			
				var inicio:int=tweenVertical.finish;//guardo en la variable la posicion final del tween vertical
				var fin:int=tweenVertical.begin;//guardo en la variable la posicion inicial del tween vertical
				tweenVertical.begin=inicio;//ahora comienzo un twin vertical y le dy el valor de la variable inicio para que me inicie desde el punto final del twin vertical
				tweenVertical.finish=fin;//y le digo que termine donde empezo el twin original
				tweenVertical.func=Regular.easeIn;//cambia el movimiento de interpolacion vertical del pez para que baje con esta funcion
				tweenVertical.removeEventListener(TweenEvent.MOTION_FINISH, darLaVuelta);//desactivo el escuchador de ventos que llama a la funcion remove event listener
				tweenVertical.start();//activo el nuevo  twin
				//antes habia un twin pero con uno tenemos suficinete				
		}
		
		private function lanzarMensajeDesaparecerPez(te:TweenEvent):void{
			
			var e:EventoPez = new EventoPez(EventoPez.DESAPARECER_PEZ);//creo objeto de la clase evento pez y lo guardo en una variable 
			this.dispatchEvent(e);//lanza el evento que guarde en la variable y el addeventlistener que este pendiente de este evento le llega el evento desaparecer pez y ejecuta la funcion
			
		}
		
		public function pararPez():void{
			this.tweenHorizontal.stop();
			this.tweenHorizontal.removeEventListener(TweenEvent.MOTION_FINISH,this.lanzarMensajeDesaparecerPez);
			this.tweenVertical.stop();
			this.tweenVertical.removeEventListener(TweenEvent.MOTION_FINISH,this.darLaVuelta);
			//funcion donde detenemos todos los los twin y evenlistener del movimiento de pez
		
		}
		
		
	}
	
}
