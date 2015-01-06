<html>
    <head>
        <style type="text/css">
            ${css}
         </style>       
    </head>
<body>
    </br></br></br>
    ${ _load('cdr',data['form']) or ''}
    <%  
        val = 0.0
        for i in range(1,16):
            val +=_get_variable('cdrc'+str(i))
            
        val1 = 0.0
        for i in range(17,21):
            val1 +=_get_variable('cdrc'+str(i))
        
        val2 = 0.0
        for i in range(21,24):
            val2 +=_get_variable('cdrc'+str(i))
        
        char = val+_get_variable('cdrc16')+val2+val2+_get_variable('cdrc24')+_get_variable('cdrc25')

        v = _get_variable('cdrp1')+_get_variable('cdrp2')
        
        v1 = 0.0
        for i in range(3,8):
            v1 +=_get_variable('cdrp'+str(i))
        
        v3=v+v1
        
        v4=0.0
        for i in range(9,15):
            v4 +=_get_variable('cdrp'+str(i))

        v5= _get_variable('cdrp15')+_get_variable('cdrp16')+_get_variable('cdrp17')

        pro = v3 + _get_variable('cdrp8')+v4+v5        
    %>

    ${(_set_variable('ct1', val)) or ''}
    ${(_set_variable('ct3',val1)) or ''}
    ${(_set_variable('ct4',val2)) or ''}
    ${(_set_variable('charges',char)) or ''}
    ${(_set_variable('pta',v)) or ''}
    ${(_set_variable('ptb', v1)) or ''}
    ${(_set_variable('pt1', v3)) or ''}
    ${(_set_variable('pt3',v4 )) or ''}
    ${(_set_variable('pt4',v5 )) or ''}
    ${(_set_variable('produits',pro )) or ''}
    
    <table class="main">
        <tr>
            <td width="30%" align="left">
                <h2>${company.name}</h2> 
                p&#xE9;riode du ${time.strftime('%d-%m-%Y',time.strptime((_get_variable('date_start')),'%Y-%m-%d'))} 
                au ${time.strftime('%d-%m-%Y',time.strptime((_get_variable('date_stop')),'%Y-%m-%d'))}
            </td>
             <td width="50%" align="center" >
                <h1>Compte de r&#xE9;sultat</h1>
            </td>
            <td width="20%" align="right" style="padding-bottom:30px;">
                Imprim&#xE9; le : ${ time.strftime('%d-%m-%Y') }
            </td>
        </tr>
        <tr>
            <td colspan="3" align="right">Tenue de Compte : ${ company.currency_id.name }</td>
        </tr>
    </table>
    </br>
    </br>
    <table class="table">
        <tr>
            <td width="70%" align="center" style="font-size:10px">
                <b>CHARGES ( hors taxes )</b>
            </td>
            <td width="30%" align="right"></td>
        </tr>
        <tr>
            <td style="font-size:11px">
                <b>CHARGES D'EXPLOITATION</b>
            </td>
            <td align="right"></td>
        </tr>
        <tr>
            <td>
                Achat de marchandises
            </td>
            <td align="right">
                ${_get_variable('cdrc1') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Variation des stocks
            </td>
            <td align="right">
                ${_get_variable('cdrc2') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Achats de mati&#xE8;res premi&#xE8;res et autres approvisionnements
            </td>
            <td align="right">
                ${_get_variable('cdrc3') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Variation des stocks
            </td>
            <td align="right">
                ${_get_variable('cdrc4') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Autres achats et charges externes
            </td>
            <td align="right">
                ${_get_variable('cdrc5') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Redevances de cr&#xE9;dit-bail mobilier
            </td>
            <td align="right">
                ${_get_variable('cdrc6') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Redevances de cr&#xE9;dit-bail immobilier
            </td>
            <td align="right">
                ${_get_variable('cdrc7') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Imp&#xF4;ts, taxes et versements assimil&#xE9;s
            </td>
            <td align="right">
                ${_get_variable('cdrc8') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Salaires et traitements
            </td>
            <td align="right">
                ${_get_variable('cdrc9') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Charges sociales
            </td>
            <td align="right">
                ${_get_variable('cdrc10') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Charges sociales
            </td>
            <td align="right">
                ${_get_variable('cdrc10') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Charges sociales
            </td>
            <td align="right">
                ${_get_variable('cdrc10') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Dotation aux amortissements et aux d&#xE9;pr&#xE9;ciations
            </td>
            <td align="right">
                ${_get_variable('cdrc10') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Sur immobilisations : dotations aux amortissements
            </td>
            <td align="right">
                ${_get_variable('cdrc11') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Sur immobilisations : dotations aux d&#xE9;pr&#xE9;ciations
            </td>
            <td align="right">
                ${_get_variable('cdrc12') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Sur actif circulant : dotations aux d&#xE9;pr&#xE9;ciations
            </td>
            <td align="right">
                ${_get_variable('cdrc13') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Dotations aux provisions
            </td>
            <td align="right">
                ${_get_variable('cdrc14') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Autres charges
            </td>
            <td align="right">
                ${_get_variable('cdrc15') or ''}
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL I</b>
            </td>
            <td align="right">
                ${_get_variable('ct1') or ''}
            </td>
        </tr>
        <tr>
            <td>
                <b>Quotes-parts de r&#xE9;sultat sur op&#xE9;rations faites en commun ( II )</b>
            </td>
            <td align="right">
                ${_get_variable('cdrc16') or ''}
            </td>
        </tr>
        <tr>
            <td style="font-size:11px">
                <b>CHARGES FINANCI&#xC8;RES</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>
                Dotations aux amortissements, aux d&#xE9;pr&#xE9;ciations et aux provisions
            </td>
            <td align="right">
                ${_get_variable('cdrc17') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Int&#xE9;r&#xEA;ts et charges assimil&#xE9;es
            </td>
            <td align="right">
                ${_get_variable('cdrc18') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Diff&#xE9;rences n&#xE9;gatives de change
            </td>
            <td align="right">
                ${_get_variable('cdrc19') or ''}
            </td>
        </tr>
        <tr>
            <td>
                Charges nettes sur cessions de valeurs mobili&#xE8;res de placement
            </td>
            <td align="right">
                ${_get_variable('cdrc20') or ''}
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>TOTAL III</b>
            </td>
            <td align="right">
                ${_get_variable('ct3') or ''}
            </td>
        </tr>
        
        <tr>
            <td style="font-size:11px">
               <b>CHARGES EXCEPTIONNELLES</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>Sur op&#xE9;rations de gestionDotations aux provisions
            </td>
            <td align="right">
                ${_get_variable('cdrc21') or ''}
            </td>
        </tr>
        <tr>
            <td>Sur op&#xE9;rations en capital
            </td>
            <td align="right">
                ${_get_variable('cdrc22') or ''}
            </td>
        </tr>
        <tr>
            <td>Dotations aux amortissements, aux d&#xE9;pr&#xE9;ciations et aux provisions
            </td>
            <td align="right">
                ${_get_variable('cdrc23') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>TOTAL IV</b>
            </td>
            <td align="right">
                ${_get_variable('ct4') or ''}
            </td>
        </tr>
        <tr>
            <td><b>Participation des salari&#xE9;s aux r&#xE9;sultats ( V )</b>
            </td>
            <td align="right">
                ${_get_variable('cdrc24') or ''}
            </td>
        </tr>
        <tr>
            <td><b>Imp&#xF4;ts sur les b&#xE9;n&#xE9;fices ( VI )</b>
            </td>
            <td align="right">
                ${_get_variable('cdrc25') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>TOTAL CHARGES ( I + II + III + IV+ V+ VI )</b>
            </td>
            <td align="right">
                ${_get_variable('charges') or ''}
            </td>
        </tr>
    </table>
    </br>
    </br></br></br></br>
    </br></br></br></br>
    </br></br></br></br>
    </br></br></br></br>
    </br></br></br>
    <table class="table">
        <tr>
            <td align="center" width="70%" style="font-size:10px"><b>PRODUITS (hors taxes)</b>
            </td>
            <td align="right" width="30%">
            </td>
        </tr>
        <tr>
            <td style="font-size:11px"><b>PRODUITS D'EXPLOITATION</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>Vente de marchandises
            </td>
            <td align="right">
                ${_get_variable('cdrp1') or ''}
            </td>
        </tr>
        <tr>
            <td>Production vendue [biens et services]
            </td>
            <td align="right">
                ${_get_variable('cdrp2') or ''}
            </td>
        </tr>
        <tr>
            <td><b>Sous-total A - Montant net du chiffre d'affaires</b>
            </td>
            <td align="right">
                ${_get_variable('pta') or ''}
            </td>
        </tr>
        <tr>
            <td>Production stock&#xE9;e
            </td>
            <td align="right">
                ${_get_variable('cdrp3') or ''}
            </td>
        </tr>
        <tr>
            <td>Production immobilis&#xE9;e
            </td>
            <td align="right">
                ${_get_variable('cdrp4') or ''}
            </td>
        </tr>
        <tr>
            <td>Subventions d'exploitation
            </td>
            <td align="right">
                ${_get_variable('cdrp5') or ''}
            </td>
        </tr>
        
        <tr>
            <td>Reprises sur provisions, d&#xE9;pr&#xE9;ciations (et amortissements) et transferts de charges
            </td>
            <td align="right">
                ${_get_variable('cdrp6') or ''}
            </td>
        </tr>
        <tr>
            <td>Autres produits
            </td>
            <td align="right">
                ${_get_variable('cdrp7') or ''}
            </td>
        </tr>
        <tr>
            <td><b>Sous-total B</b>
            </td>
            <td align="right">
                ${_get_variable('ptb') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>TOTAL I ( A + B )</b>
            </td>
            <td align="right">
                ${_get_variable('pt1') or ''}
            </td>
        </tr>
        <tr>
            <td><b>Quotes-parts de r&#xE9;sultat sur op&#xE9;rations faites en commun (II)</b>
            </td>
            <td align="right">
                ${_get_variable('cdrp8') or ''}
            </td>
        </tr>
        <tr>
            <td><b>PRODUITS FINANCIERS</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>Quotes-parts de r&#xE9;sultat sur op&#xE9;rations faites en commun (II)
            </td>
            <td align="right">
                ${_get_variable('cdrp8') or ''}
            </td>
        </tr>
        <tr>
            <td>De participation
            </td>
            <td align="right">
                ${_get_variable('cdrp9') or ''}
            </td>
        </tr>
        
        <tr>
            <td>D'autres valeurs mobili&#xE8;res et cr&#xE9;ances de l'actif immobilis&#xE9;
            </td>
            <td align="right">
                ${_get_variable('cdrp10') or ''}
            </td>
        </tr>
        <tr>
            <td>Autres int&#xE9;r&#xEA;ts et produits assimil&#xE9;s
            </td>
            <td align="right">
                ${_get_variable('cdrp11') or ''}
            </td>
        </tr>
        <tr>
            <td>Reprises sur provisions, d&#xE9;pr&#xE9;ciations et transferts de charges
            </td>
            <td align="right">
                ${_get_variable('cdrp12') or ''}
            </td>
        </tr>
        <tr>
            <td>Diff&#xE9;rences positives de change
            </td>
            <td align="right">
                ${_get_variable('cdrp13') or ''}
            </td>
        </tr>
        <tr>
            <td>Produits nets sur cessions de valeurs mobili&#xE8;res de placement
            </td>
            <td align="right">
                ${_get_variable('cdrp14') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>TOTAL III</b>
            </td>
            <td align="right">
                ${_get_variable('pt3') or ''}
            </td>
        </tr>
        <tr>
            <td><b>PRODUITS EXCEPTIONNELS</b>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td>Sur op&#xE9;rations de gestion
            </td>
            <td align="right">
                ${_get_variable('cdrp15') or ''}
            </td>
        </tr>
        <tr>
            <td>Sur op&#xE9;rations en capital
            </td>
            <td align="right">
                ${_get_variable('cdrp16') or ''}
            </td>
        </tr>
         <tr>
            <td>Reprises sur provisions, d&#xE9;pr&#xE9;ciations et transferts de charges
            </td>
            <td align="right">
                ${_get_variable('cdrp17') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>TOTAL IV</b>
            </td>
            <td align="right">
                ${_get_variable('pt4') or ''}
            </td>
        </tr>
         <tr>
            <td align="right"><b>TOTAL DES PRODUITS ( I + II + III + IV )</b>
            </td>
            <td align="right">
                ${_get_variable('produits') or ''}
            </td>
        </tr>
        <tr>
            <td align="right"><b>PRODUITS - CHARGES</b>
            </td>
            <%
                ans=( (_get_variable('produits')) - (_get_variable('charges')) )
            %>
            <td align="right">
                ${ans}
            </td>
        </tr>
    </table>
</body>
</html>