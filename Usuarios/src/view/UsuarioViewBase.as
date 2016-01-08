package view
{
	import event.UsuarioEvent;
	
	import flash.events.MouseEvent;
	
	import model.EmpleadoVO;
	import model.PerfilVO;
	import model.UsuarioDTO;
	import model.UsuarioModel;
	
	import mx.controls.Alert;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import spark.components.Group;
	
	public class UsuarioViewBase extends Group
	{
		[Inject]
		[Bindable]
		public var usuarioModel:UsuarioModel;
		
		private var usuarioView:UsuarioView = UsuarioView(this);
		private var usuarioEvent:UsuarioEvent = null;
		
		/************	VALIDATOR'S	*********************/
		private var arrayValidationResult:Array = null;
		
		public function UsuarioViewBase()
		{
			super();
		}
		
		/**
		 * Crear Usuario
		 */
		protected function createUpdateUsuario():void{
			usuarioModel.usuarioSelected = new UsuarioDTO();
			usuarioView.autocompleteEmpleado.selectedItem = null;
			usuarioView.txtPassword.text = "";
			usuarioView.txtPasswordRep.text = "";
			usuarioView.cmbPerfiles.selectedItem = null;
		}

		public function createUsuario():void{
            clearFormulario();
		}

        /**
         * Usuario seleccionado en el Grid
         */
        protected function usuarioSelected(e:MouseEvent):void{
            //clearValidators()
            if(e.currentTarget.selectedItem != null){
                usuarioModel.titleFormulario = UsuarioModel.ACTUALIZAR;
                usuarioModel.usuarioSelected = e.currentTarget.selectedItem as UsuarioDTO;

                //Selected Empleado
                for each(var _empleado:EmpleadoVO in usuarioModel.acEmpleados){
                    if(_empleado.idEmpleado == usuarioModel.usuarioSelected.idEmpleado){
                        if(usuarioView.autocompleteEmpleado.selectedItem == null
                            || usuarioView.autocompleteEmpleado.selectedItem == ""){
                            usuarioView.autocompleteEmpleado.selectedItem = _empleado;
							usuarioView.autocompleteEmpleado.errorString = "";
                        }else if((EmpleadoVO(usuarioView.autocompleteEmpleado.selectedItem).idEmpleado != _empleado.idEmpleado)){
                            usuarioView.autocompleteEmpleado.selectedItem = _empleado;
							usuarioView.autocompleteEmpleado.errorString = "";
                        }
                        break;
                    }
                }

                //Set passwords
                usuarioView.txtPassword.text = usuarioModel.usuarioSelected.pass;
                usuarioView.txtPasswordRep.text = usuarioModel.usuarioSelected.pass;

                //Selected Perfil
                for each(var _perfil:PerfilVO in usuarioModel.acPerfiles){
                    if(_perfil.idPerfil == usuarioModel.usuarioSelected.idPerfil){
                        usuarioView.cmbPerfiles.selectedItem = _perfil;
						usuarioView.cmbPerfiles.errorString = "";
                    }
                }

            }
        }

        /**
         * Clear Formulario
         */
        protected function clearFormulario():void{
			usuarioModel.titleFormulario = UsuarioModel.CREAR;
            usuarioView.autocompleteEmpleado.selectedItem = null;
            usuarioView.cmbPerfiles.selectedItem = null;
            usuarioView.txtPassword.text = "";
            usuarioView.txtPasswordRep.text = "";
			
			usuarioView.autocompleteEmpleado.errorString = "";
			usuarioView.txtPassword.errorString = "";
			usuarioView.txtPasswordRep.errorString = "";
			usuarioView.cmbPerfiles.errorString = "";
			
			usuarioEvent = null;
        }

        /**
         * Guarda el usuario, ya sea un nuevo usuario o la actualización de los datos de un nuevo Usuario
         */
        protected function saveUsuario ():void{
            var flagValidators:Boolean = validateFields();
			if(flagValidators){
	            usuarioModel.usuarioSelected.idEmpleado = EmpleadoVO(usuarioView.autocompleteEmpleado.selectedItem).idEmpleado;
	            usuarioModel.usuarioSelected.idPerfil = PerfilVO(usuarioView.cmbPerfiles.selectedItem).idPerfil;
	            usuarioModel.usuarioSelected.pass = usuarioView.txtPassword.text;
	
	            if(usuarioModel.usuarioSelected.idUsuario != null
	                && usuarioModel.usuarioSelected.idUsuario != ""){
	                usuarioEvent = new UsuarioEvent(UsuarioEvent.UPDATE_USUARIO_EVENT);
	            }else{
	                usuarioEvent = new UsuarioEvent(UsuarioEvent.SAVE_USUARIO_EVENT);
	            }
	            if(usuarioEvent != null) {
					dispatchEvent(usuarioEvent);
					clearFormulario();
	            }
			}
        }

        /**
         * Valid All Fields
         * @return
         */
        private function validateFields():Boolean{
            if(usuarioView.autocompleteEmpleado.selectedItem != null
                && usuarioView.cmbPerfiles.selectedItem != null){
                arrayValidationResult = Validator.validateAll([usuarioView.validatorEmpleado, usuarioView.validatorPerfil, usuarioView.validatorPassword, usuarioView.validatorPasswordRep]);
				if(arrayValidationResult.length == 0
					&& usuarioView.autocompleteEmpleado.errorString.length == 0
					&& usuarioView.cmbPerfiles.errorString.length == 0
					&& usuarioView.txtPassword.errorString.length == 0
					&& usuarioView.txtPasswordRep.errorString.length == 0){
                    return true;
                }else{
					if(usuarioView.autocompleteEmpleado.selectedItem == null){
						usuarioView.autocompleteEmpleado.errorString = "Debes seleccionar un Empleado";
					}
					if(usuarioView.cmbPerfiles.selectedItem == null){
						usuarioView.cmbPerfiles.errorString = "Debes seleccionar un perfil";
					}
				}
            }
            return false;
        }

        /**
         * Select complement of fields User
         */
        private function selectedComplementFieldsUser():void{
            if(usuarioModel.usuarioSelected != null
                && usuarioModel.usuarioSelected.idEmpleado != null
                && usuarioModel.usuarioSelected.idPerfil != null
                && usuarioModel.usuarioSelected.idUsuario != null){
                for each(var _empleado:EmpleadoVO in usuarioModel.acEmpleados){
                    if(_empleado.idEmpleado == usuarioModel.usuarioSelected.idEmpleado){
                        usuarioView.autocompleteEmpleado.selectedItem = _empleado;
                        break;
                    }
                }

                usuarioView.txtPassword.text = usuarioModel.usuarioSelected.pass;
                usuarioView.txtPasswordRep.text = usuarioModel.usuarioSelected.pass;

                for each(var _perfil:PerfilVO in usuarioModel.acPerfiles){
                    if(_perfil.idPerfil == usuarioModel.usuarioSelected.idPerfil){
                        usuarioView.cmbPerfiles.selectedItem = _perfil;
                        break;
                    }
                }
            }
        }

        /**
         * When selected a Employee valid if this Employee don't exists in Array
         */
        protected function selectedEmpleado():void{
            var flagSelected:Boolean = false;
            var _empleado:EmpleadoVO = usuarioView.autocompleteEmpleado.selectedItem as EmpleadoVO;
			if(_empleado != null) {
				if((usuarioModel.usuarioSelected.idUsuario == null || usuarioModel.usuarioSelected.idUsuario == "")
					|| 
					((usuarioModel.usuarioSelected.idEmpleado != null && (usuarioModel.usuarioSelected.idEmpleado != _empleado.idEmpleado)))){
					for each(var _user:UsuarioDTO in usuarioModel.acUsuarios){
						if(_user.idEmpleado == _empleado.idEmpleado){
							usuarioView.dataGridUsuarios.selectedItem = _user;
							usuarioView.dataGridUsuarios.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK, false, false));
							flagSelected = true;
							break;
						}
					}
				}
            }
            if(!flagSelected){
				usuarioModel.usuarioSelected = new UsuarioDTO();
				usuarioModel.titleFormulario = UsuarioModel.CREAR;
				usuarioView.dataGridUsuarios.selectedItem = null;
                usuarioView.cmbPerfiles.selectedItem = null;
                usuarioView.txtPassword.text = "";
                usuarioView.txtPasswordRep.text = "";
                usuarioView.txtPassword.errorString = "";
                usuarioView.txtPasswordRep.errorString = "";
            }
        }


        /**
         * Validate Handler Empleado
         */
        protected function validEmpleado(e:ValidationResultEvent):void{
            usuarioView.autocompleteEmpleado.errorString = "";
        }

        /**
         * Invalid Handler Empleado
         */
        protected function invalidEmpleado(e:ValidationResultEvent):void{
            usuarioView.autocompleteEmpleado.errorString = "Debes seleccionar un Empleado";
        }

        /**
         * Validate Handler Perfil
         */
        protected function validPerfil(e:ValidationResultEvent):void{
            usuarioView.cmbPerfiles.errorString = "";
        }

        /**
         * Invalid Handler Perfil
         */
        protected function invalidPerfil(e:ValidationResultEvent):void{
            usuarioView.cmbPerfiles.errorString = "Debes seleccionar un Perfil";
        }

        /**
         * Delete Usuario
         */
        protected function deleteUsuario():void{
            if(usuarioModel.usuarioSelected.idUsuario != null
                && usuarioModel.usuarioSelected.idUsuario != "") {
                usuarioEvent = new UsuarioEvent(UsuarioEvent.DELETE_USUARIO_EVENT);
				dispatchEvent(usuarioEvent);
				clearFormulario();
            }
        }

        /**
		 * Label Function para mostrar la marca y el nombre del Artícuo concatenados
		 */
		protected function labelFunctionNombre (item:Object):String{
			return item.nombre + " " + item.paterno + " " + item.materno;
		}
		
		/**
		 * Function that valid password
		 */
		protected function validPassword():void{
			if(usuarioView.txtPassword.text != "" && usuarioView.txtPassword.text.length > 1){
				usuarioView.txtPassword.errorString = "";
				if(usuarioView.txtPassword.text.length == usuarioView.txtPasswordRep.text.length){
					if(usuarioView.txtPassword.text == usuarioView.txtPasswordRep.text){
						usuarioView.txtPasswordRep.errorString = "";
					}else{
						usuarioView.txtPasswordRep.errorString = "El password debe de coincidir";
					}
				}else{
					usuarioView.txtPasswordRep.errorString = "El password debe de coincidir";
				}
			}else{
				if(usuarioView.txtPasswordRep.text != ""){
					usuarioView.txtPassword.errorString = "Debes ingresar un password";
				}else{
					usuarioView.txtPassword.errorString = "";
					usuarioView.txtPasswordRep.errorString = "";
				}
			}
		}
	}
}