<html>
    <head>
        <style type="text/css">
            ${css}
         </style>       
    </head>
<body>
    </br></br></br></br>
    ${ _load('bilan',data['form']) or ''}
    <% 
        at1a=_get_variable('at1a')
        at1b=_get_variable('at1b')
        a = at1a+at1b
        at2a=_get_variable('at2a')
        at2b=_get_variable('at2b')
        b = at2a + at2b
        val=0.0
        val1=0.0
        valb=0.0
        valb1=0.0
        vala=_get_variable('at1')+_get_variable('at2')+_get_variable('bavar34')+_get_variable('bavar35')+_get_variable('bavar36')
        for i in range(1,21):
            val +=_get_variable('bavar'+str(i))
        for i in range(21,34):
            val1 +=_get_variable('bavar'+str(i))
            
        bpval=0.0
        for i in range(1,13):
            bpval +=_get_variable('bpvar'+str(i))

        bpval1=0.0
        for i in range(15,23):
            bpval +=_get_variable('bpvar'+str(i))
            
        for i in range(2,21):
            if i == 8 :
                continue
            if i == 14 :
                continue;
            else:
                valb +=_get_variable('bavar'+str(i)+'b')
                
        for i in range(21,31):
            if i == 25 :
                continue
            if i == 28 :
                continue;
            else:
                valb1 +=_get_variable('bavar'+str(i)+'b')
                
        valpt=_get_variable('bpvar13')+_get_variable('bpvar14')
        pt = bpval+valpt+bpval1+_get_variable('bpvar26')
    %>
    ${ _set_variable('at1a',val) or ''}
    ${ _set_variable('at1b',valb) or ''}
    ${ _set_variable('at1',a) or ''}
    ${ _set_variable('at2a',val1) or ''}
    ${ _set_variable('at2b',valb1) or ''}
    ${ _set_variable('at2',b) or '' }
    ${ _set_variable('actif',vala) or ''}
    ${ _set_variable('pt1',bpval) or ''}
    ${ _set_variable('pt2', valpt) or ''}
    ${ _set_variable('pt3', bpval1) or ''}
    ${ _set_variable('passif',pt) or ''}
    <table class="main">
        <tr>
            <td width="18%" align="left">
                <h2>${company.name}</h2> au ${time.strftime('%d-%m-%Y',time.strptime(_get_end_date(),'%Y-%m-%d'))}
            </td>
             <td width="62%" align="center" >
                <h1>Bilan</h1>
            </td>
            <td width="20%" align="right" style="padding-bottom:30px;">
                Imprim&#xE9; le : ${ time.strftime('%d-%m-%Y') }
            </td>
        </tr>
        <tr>
            <td colspan="3" align="right">Tenue de Compte : ${ company.currency_id.name }</td>
        </tr>
    </table>
    <h3>${_("   ACTIF")}</h3>
    <table class="table">
        <tr>
            <td width="40%">
                
            </td>
            <td align="right" width="20%">
                ${_("Brut")}
            </td>
            <td align="right" width="23%">
                Amortissements et d&#xE9;pr&#xE9;ciations
            </td>
            <td align="right" width="17%">
                Net
            </td>
        </tr>
        <tr>
            <td width="40%">
                <b><font face="Times-Roman" size="1.0">Capital souscrit - non appel&#xE9;</font></b>
            </td>
            <td align="right" width="20%">
                %if _get_variable('bavar1') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar1')}
                %endif
            </td>
            <td align="right" width="23%">
            </td>
            <td align="right" width="17%">
                %if _get_variable('bavar1') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar1')}
                %endif
            </td>
        </tr>
        <tr>
            <td>
            <b>ACTIF IMMOBILIS&#xC9;</b>
            </td>
            <td></td><td></td><td></td>
        </tr>
        <tr>
            <td>
              <b>IMMOBILISATIONS INCORPORELLES</b>
            </td>
            <td></td><td></td><td></td>
        </tr>
        <tr>
            <td>
              Frais d'&#xE9;tablissement
            </td>
            <td align="right">
                 %if _get_variable('bavar2') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar2') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar2b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar2b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar2') + _get_variable('bavar2b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar2') + _get_variable('bavar2b') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>Frais de recherche et de d&#xE9;veloppement</td>
            <td align="right">
                %if _get_variable('bavar3') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar3') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar3b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar3b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar3') + _get_variable('bavar3b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar3') + _get_variable('bavar3b') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>Concessions, brevets, licences,..., droits et valeurs similaires</td>
            <td align="right">
                %if _get_variable('bavar4') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar4') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar4b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar4b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar4') + _get_variable('bavar4b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar4') + _get_variable('bavar4b') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>Fonds commercial</td>
            <td align="right">
                %if _get_variable('bavar5') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar5') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar5b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar5b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar5') + _get_variable('bavar5b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar5') + _get_variable('bavar5b') or ''}
                %endif
            </td>
          </tr>
          <tr>
            <td>Autres</td>
            <td align="right">
                %if _get_variable('bavar6') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar6') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar6b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar6b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar6') + _get_variable('bavar6b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar6') + _get_variable('bavar6b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Immobilisations incorporelles en cours</td>
            <td align="right">
                %if _get_variable('bavar7') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar7') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar7b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar7b')or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar7') + _get_variable('bavar7b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar7') + _get_variable('bavar7b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Avances et acomptes</td>
            <td align="right">
                %if _get_variable('bavar8') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar8') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar8') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar8') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>
                <b>IMMOBILISATIONS CORPORELLES</b>
            </td>
            <td align="right">
            </td>
            <td align="right">
            </td>
            <td align="right">
            </td>
         </tr>
         <tr>
            <td>Terrains</td>
            <td align="right">
                %if _get_variable('bavar9') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar9') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar9b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar9b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar9') + _get_variable('bavar9b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar9') + _get_variable('bavar9b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Constructions</td>
            <td align="right">
                %if _get_variable('bavar10') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar10') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar10b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar10b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar10') + _get_variable('bavar10b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar10') + _get_variable('bavar10b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Installations techniques,mat&#xE9;riel et outillage</td>
            <td align="right">
                %if _get_variable('bavar11') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar11') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar11b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar11b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar11') + _get_variable('bavar11b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar11') + _get_variable('bavar11b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Autres</td>
            <td align="right">
                %if _get_variable('bavar12') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar12') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar12b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar12b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar12') + _get_variable('bavar12b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar12') + _get_variable('bavar12b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Immobilisations corporelles en cours</td>
            <td align="right">
                %if _get_variable('bavar13') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar13') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar13b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar13b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar13') + _get_variable('bavar13b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar13') + _get_variable('bavar13b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Avances et acomptes</td>
            <td align="right">
                %if _get_variable('bavar14') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar14') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                 %if _get_variable('bavar14') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar14') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>IMMOBILISATIONS FINANCI&#xC9;RES</td>
            <td align="right">
            </td>
            <td align="right">
            </td>
            <td align="right">
            </td>
         </tr>
         <tr>
            <td>Participations</td>
            <td align="right">
                %if _get_variable('bavar15') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar15') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar15b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar15b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar15') + _get_variable('bavar15b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar15') + _get_variable('bavar15b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Cr&#xE9;ances rattach&#xE9;es &#xE0; des participations</td>
            <td align="right">
                %if _get_variable('bavar16') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar16') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar16b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar16b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar16') + _get_variable('bavar16b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar16') + _get_variable('bavar16b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Titres immobilis&#xE9;s de l'activit&#xE9; de portefeuille</td>
            <td align="right">
                %if _get_variable('bavar17') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar17') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar17b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar17b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar17') + _get_variable('bavar17b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar17') + _get_variable('bavar17b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Autres titres immobilis&#xE9;s</td>
            <td align="right">
                %if _get_variable('bavar18') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar18') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar18b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar18b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar18') + _get_variable('bavar18b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar18') + _get_variable('bavar18b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Pr&#xEA;ts</td>
            <td align="right">
                %if _get_variable('bavar19') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar19') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar19b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar19b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar19') + _get_variable('bavar19b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar19') + _get_variable('bavar19b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Autres</td>
            <td align="right">
                %if _get_variable('bavar20') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar20') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar20b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar20b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar20') + _get_variable('bavar20b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar20') + _get_variable('bavar20b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right"><b>TOTAL I</b></td>
            <td align="right">
                %if _get_variable('at1a') == 0.0:
                    ${}
                %else:
                    ${_get_variable('at1a') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-at1b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-at1b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('at1') + _get_variable('at1') == 0.0:
                    ${}
                %else:
                    ${_get_variable('at1') + _get_variable('at1') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>
                <b>ACTIF CIRCULANT</b>
            </td>
            <td></td><td></td><td></td>
         </tr>
         <tr>
            <td>
                <b>STOCK EN COURS</b>
            </td>
            <td></td><td></td><td></td>
         </tr>
         <tr>
            <td>Mati&#xE8;res premi&#xE8;res et autres approvisionnements</td>
            <td align="right">
                %if _get_variable('bavar21') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar21') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar21b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar21b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar21') + _get_variable('bavar21b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar21') + _get_variable('bavar21b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>En-cours de production [biens et services]</td>
            <td align="right">
                %if _get_variable('bavar22') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar22') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar22b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar22b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar22') + _get_variable('bavar22b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar22') + _get_variable('bavar22b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Produits interm&#xE9;diaires et finis</td>
            <td align="right">
                %if _get_variable('bavar23') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar23') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar23b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar23b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar23') + _get_variable('bavar23b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar23') + _get_variable('bavar23b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Marchandises</td>
            <td align="right">
                %if _get_variable('bavar24') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar24') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar24b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar24b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar24') + _get_variable('bavar24b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar24') + _get_variable('bavar24b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Avances et acomptes vers&#xE9;s sur commandes</td>
            <td align="right">
                %if _get_variable('bavar25') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar25') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar25') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar25') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>
                <b>CR&#xC9;ANCES</b>
            </td>
            <td></td><td></td><td></td>
         </tr>
         <tr>
            <td>Cr&#xE9;ances clients et comptes rattach&#xE9;s</td>
            <td align="right">
                %if _get_variable('bavar26') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar26') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar26b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar26b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar26') + _get_variable('bavar26b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar26') + _get_variable('bavar26b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Autres</td>
            <td align="right">
                %if _get_variable('bavar27') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar27') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar27b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar27b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar27') + _get_variable('bavar27b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar27') + _get_variable('bavar27b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Avances et acomptes vers&#xE9;s sur commandes</td>
            <td align="right">
                %if _get_variable('bavar28') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar28') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar28') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar28') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>
                <b>VALEURS MOBILI&#xC8;RES DE PLACEMENT</b>
            </td>
            <td></td><td></td><td></td>
         </tr>
         <tr>
            <td >Actions propres</td>
            <td align="right">
                %if _get_variable('bavar29') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar29') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar29b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar29b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar29') + _get_variable('bavar29b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar29') + _get_variable('bavar29b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Autres titres</td>
            <td align="right">
                %if _get_variable('bavar30') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar30') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-bavar30b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-bavar30b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('bavar30') + _get_variable('bavar30b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar30') + _get_variable('bavar30b') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td >Instruments de tr&#xE9;sorerie</td>
            <td align="right">
                %if _get_variable('bavar31') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar31') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar31') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar31') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Disponibilit&#xE9;s</td>
            <td align="right">
                %if _get_variable('bavar32') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar32') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar32') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar32') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td>Charges constat&#xE9;s d'avance</td>
            <td align="right">
                %if _get_variable('bavar33') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar33') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar33') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar33') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right"><b>TOTAL II</b></td>
            <td align="right">
                %if _get_variable('at2a') == 0.0:
                    ${}
                %else:
                    ${_get_variable('at2a') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('-at2b') == 0.0:
                    ${}
                %else:
                    ${_get_variable('-at2b') or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('at2') + _get_variable('at2') == 0.0:
                    ${}
                %else:
                    ${_get_variable('at2') + _get_variable('at2') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right">Charges &#xE0; r&#xE9;partir sur plusieurs exercices( III )</td>
            <td align="right">
                %if _get_variable('bavar34') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar34') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar34') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar34') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right">Primes de remboursement des emprunts( IV )</td>
            <td align="right">
                %if _get_variable('bavar35') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar35') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar35') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar35') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right">&#xC9;carts de conversion actif( V )</td>
            <td align="right">
                %if _get_variable('bavar36') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar36') or ''}
                %endif
            </td>
            <td align="right">
            </td>
            <td align="right">
                %if _get_variable('bavar36') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bavar36') or ''}
                %endif
            </td>
         </tr>
         <tr>
            <td align="right"><b>TOTAL ACTIF  ( I + II + III + IV + V )</b></td>
            <td align="right">
                <%
                    h2=_get_variable('at1a')+_get_variable('at2a')
                %>
                %if h2  == 0.0:
                    ${}
                %else:
                    ${h2 or ''}
                %endif
            </td>
            <td align="right">
                %if ( (_get_variable('at1a'))+(_get_variable('at2a')) )== 0.0:
                    ${}
                %else:
                   - ${( (_get_variable('at1a')) + (_get_variable('at2a')) ) or ''}
                %endif
            </td>
            <td align="right">
                %if _get_variable('actif') == 0.0:
                    ${}
                %else:
                    ${_get_variable('actif') or ''}
                %endif
            </td>
         </tr>
    </table>
    <h3>${_("   PASSIF")}</h3>
    <table class="table">
        <tr>
            <td width="45%">
                <b>CAPITAUX PROPRES</b>
            </td>
            <td width="55%" align="right">
            </td>
        </tr>
        <tr>
            <td width="45%">
                Capital [dont vers&#xE9;...]
            </td>
            <td width="55%" align="right">
                %if _get_variable('bpvar1') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar1') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Primes d'&#xE9;mission, de fusion, d'apport
            </td>
            <td width="55%" align="right">
                %if _get_variable('bpvar2') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar2') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                &#xC9;carts de r&#xE9;&#xE9;valuation
            </td>
            <td width="55%" align="right">
                %if _get_variable('bpvar3') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar3') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                &#xC9;cart d'&#xE9;quivalence
            </td>
            <td align="right">
                %if _get_variable('bpvar4') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar4') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                <b>R&#xC9;SERVES</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>
                R&#xE9;serve l&#xE9;gale
            </td>
            <td align="right">
                %if _get_variable('bpvar5') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar5') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                R&#xE9;serves statutaires ou contractuelles
            </td>
            <td align="right">
                %if _get_variable('bpvar6') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar6') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                R&#xE9;serves r&#xE9;glement&#xE9;es
            </td>
            <td align="right">
                %if _get_variable('bpvar7') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar7') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Autres r&#xE9;serves
            </td>
            <td align="right">
                %if _get_variable('bpvar8') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar8') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Report &#xE0; nouveau
            </td>
            <td align="right">
                %if _get_variable('bpvar9') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar9') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                <b>R&#xC9;SULTAT DE L'EXERCICE [b&#xE9;n&#xE9;fice ou perte]</b>
            </td>
            <td align="right">
                %if _get_variable('bpvar10') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar10') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Subventions d'investissement
            </td>
            <td align="right">
                %if _get_variable('bpvar11') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar11') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Provisions r&#xE9;glement&#xE9;es
            </td>
            <td align="right">
                %if _get_variable('bpvar12') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar12') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL I</b>
            </td>
            <td align="right">
                    ${_get_variable('pt1') or ''}
            </td>
        </tr>
        <tr>
            <td>
               <b>PROVISIONS</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>
                Provisions pour risques
            </td>
            <td align="right">
                %if _get_variable('bpvar13') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar13') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Provisions pour charges
            </td>
            <td align="right">
                %if _get_variable('bpvar14') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar14') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL II</b>
            </td>
            <td align="right">
                %if _get_variable('pt2') == 0.0:
                    ${}
                %else:
                    ${_get_variable('pt2') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                <b>DETTES</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>
                Emprunts obligataires convertibles
            </td>
            <td align="right">
                %if _get_variable('bpvar15') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar15') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Autres emprunts obligataires
            </td>
            <td align="right">
                %if _get_variable('bpvar16') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar16') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Emprunts et dettes aupr&#xE8;s des &#xE9;tablissements de cr&#xE9;dit
            </td>
            <td align="right">
                %if _get_variable('bpvar17') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar17') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Emprunts et dettes financi&#xE8;res diverses
            </td>
            <td align="right">
                %if _get_variable('bpvar18') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar18') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Avances et acomptes re&#xE7;us sur commandes en cours
            </td>
            <td align="right">
                %if _get_variable('bpvar19') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar19') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Dettes fournisseurs et comptes rattach&#xE9;s
            </td>
            <td align="right">
                %if _get_variable('bpvar20') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar20') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Dettes fiscales et sociales
            </td>
            <td align="right">
                %if _get_variable('bpvar21') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar21') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Dettes sur immobilisations et comptes rattach&#xE9;s
            </td>
            <td align="right">
                %if _get_variable('bpvar22') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar22') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Autres dettes
            </td>
            <td align="right">
                %if _get_variable('bpvar23') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar23') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Instruments de tr&#xE9;sorerie
            </td>
            <td align="right">
                %if _get_variable('bpvar24') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar24') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td>
                Produits constat&#xE9;s d'avance
            </td>
            <td align="right">
                %if _get_variable('bpvar25') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar25') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL III</b>
            </td>
            <td align="right">
                %if _get_variable('pt3') == 0.0:
                    ${}
                %else:
                    ${_get_variable('pt3') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td align="right">
                &#xC9;carts de conversion passif ( IV )
            </td>
            <td align="right">
                %if _get_variable('bpvar26') == 0.0:
                    ${}
                %else:
                    ${_get_variable('bpvar26') or ''}
                %endif
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL G&#xC9;N&#xC9;RAL (I + II + III + IV)</b>  
            </td>
            <td align="right">
                    ${_get_variable('passif') or ''}
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>ACTIF - PASSIF</b>
            </td>
            <%
               ans=round(((_get_variable('actif')) - (_get_variable('passif'))) ,2)
               
            %>
            <td align="right">
                    ${ans}
            </td>
        </tr>
    </table>
    </br>
    ${_abs()}
</body>
</html>