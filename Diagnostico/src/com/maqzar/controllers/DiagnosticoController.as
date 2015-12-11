///**
// * Created by jess on 08/08/15.
// */
//package com.maqzar.controllers {
//import com.maqzar.dtos.EquipoVO;
//import com.maqzar.dtos.SubFallaDTO;
//import com.maqzar.models.DiagnosticoModel;
//import com.maqzar.services.DiagnosticoServices;
//
//import mx.collections.ArrayCollection;
//import mx.controls.Alert;
//
//import mx.rpc.events.FaultEvent;
//
//import mx.rpc.events.ResultEvent;
//
//import org.swizframework.controller.AbstractController;
//
//public class DiagnosticoController extends AbstractController {
//    private var diagnosticoService:DiagnosticoServices = new DiagnosticoServices();
//    [Inject]
//    public var diagnosticoModel:DiagnosticoModel;
//    public function DiagnosticoController() {
//        super();
//    }
//
//    [EventHandler(event = "DiagnosticoEvent.DIAGNOSTICO_GET_FALLAS", properties="subfalla")]
//    public function valores_iniciales(subfalla:SubFallaDTO):void{
//
//        executeServiceCall(diagnosticoService.infoFalla(subfalla),infoFallaResult,diagnosticoFault);
//    }
//
//    private function diagnosticoFault(e:FaultEvent):void {
//        Alert.show(e.fault.message,"Mensaje");
//
//    }
//
//    private function infoFallaResult(e:ResultEvent):void {
//        try{
//            trace(e.result);
//            if(e.result != null){
//                diagnosticoModel.acSubfallas = e.result as ArrayCollection;
//            }else{
//                Alert.show("No pudo cargar las subfallas","NOK")
//            }
//        }catch(e:Error){
//            trace(e.message);
//        }
//    }
//    private function infoEquipoResult(e:ResultEvent):void{
//        try{
//            trace(e.result);
//            if(e.result != null){
//                diagnosticoModel.acEquipo = e.result as ArrayCollection;
//            }else{
//                Alert.show("No pudo cargar el equipo","NOK")
//            }
//        }catch(e:Error){
//            trace(e.message);
//        }
//    }
//
//    private function infoEquipoFault(e:FaultEvent):void {
//        Alert.show(e.fault.message,"Mensaje");
//
//    }
//}
//}
