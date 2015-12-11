/**
 * Created by jess on 08/08/15.
 */
package com.maqzar.services {
import com.maqzar.constant.NOKConstants;
import com.maqzar.dtos.DiagnosticoDTO;
import com.maqzar.dtos.EquipoVO;
import com.maqzar.dtos.SubFallaDTO;

import mx.rpc.AsyncToken;

import mx.rpc.remoting.RemoteObject;

public class DiagnosticoServices {
    private var diagnosticoRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_DIAGNOSTICO);
    private var equipoRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_EQUIPOS);
    private var fallaRemote:RemoteObject = new RemoteObject(NOKConstants.SERVICE_DESTINATION_FALLAS);
    public function DiagnosticoServices() {
        diagnosticoRemote.endpoint = NOKConstants.SERVICE_URL;
        diagnosticoRemote.showBusyCursor = true;
        equipoRemote.endpoint = NOKConstants.SERVICE_URL;
        equipoRemote.showBusyCursor = true;
        fallaRemote.endpoint = NOKConstants.SERVICE_URL;
        fallaRemote.showBusyCursor = true;



    }

    public function insertDiagnostico(dto:DiagnosticoDTO):AsyncToken{
        return diagnosticoRemote.insertDiagnostico(dto);
    }

    public function updateDiagnostico(dto:DiagnosticoDTO):AsyncToken{
        return diagnosticoRemote.updateDiagnostico(dto);
    }

    public function deleteDiagnostico(dto:DiagnosticoDTO):AsyncToken{
        return diagnosticoRemote.deleteDiagnostico(dto);
    }

    public function infoDiagnostico(dto:DiagnosticoDTO):AsyncToken{
        return diagnosticoRemote.infoDiagnostico(dto);
    }

    public function infoFalla(subFalla:SubFallaDTO):AsyncToken{
        return fallaRemote.catSubfalla(subFalla);
    }
    public function infoEquipo(equipoInfo:EquipoVO):AsyncToken{
        return equipoRemote.catEquipo(equipoInfo);
    }
}
}
