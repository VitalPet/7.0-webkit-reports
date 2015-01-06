<html>
    <head>
        <style type="text/css">
             ${css}
         </style>       
    </head>
<body>
    %for o in objects:
        <table width="100%">
            <tr>
                <td width="45%">
                    <table width="100%">
                        <tr>
                          <td class="border" width="100%">
                                BULLETIN DE PAIE
                          </td>
                        </tr>
                        <tr>
                            <td width="100%" style:padding-bottom:0px;>
                                <h5><b> PAIE DU ${ formatLang(o.date_from, date=True) or ''} AU ${ formatLang(o.date_to, date=True) or '' }</b></h5>
                            </td>
                        </tr>
                        <tr>
                             <td class="list_table">
                                            Matricule :    <para style="padding-left:14px"> ${ o.employee_id.sinid or '_'}</para></br>
                                            N° s.s :         <para style="padding-left:25px">${ o.employee_id.ssnid or '_' }</para></br>
                                            Emploi :         <para style="padding-left:25px">${ o.contract_id.job_id.name or '_'}</para></br>
                                            Qualif :         <para style="padding-left:30px">${ o.contract_id.qualif or '_'}</para></br>
                                            Niveau :         <para style="padding-left:24px">${ o.contract_id.niveau or '_'}</para></br>
                                            Coef :          <para style="padding-left:35px">${ o.contract_id.coef or '_'}</para></br>
                                            Entrée :        <para style="padding-left:25px"> ${ o.contract_id.date_start or '_'} Sortie : ${o.contract_id.date_end or ''}</para></br>
                                            ORG. S.S :      <para style="padding-left:11px">${ o.employee_id.company_id.org_ss or '_' }</para>
                            </td>
                         </tr>
                         </table>
                     </td>
                <td width="10%">
                </td>
                <td width="45%">
                    <table width="100%">
                         <tr>
                          <td class="list_table">
                            ${ o.employee_id.company_id.partner_id.title.name or ''} ${o.employee_id.company_id.name or '_'}</br>
                            ${ o.employee_id.company_id.street or '_'}</br>
                            ${ o.employee_id.company_id.street2 or ''}</br>
                            ${ o.employee_id.company_id.zip or '_'} ${ o.employee_id.company_id.city or ''}</br>
                            SIRET : ${o.employee_id.company_id.siret or '_'} APE : ${ o.employee_id.company_id.ape or '_' }
                          </td>
                        </tr>
                        <tr> <td width="100%"> </td></tr>
                        <tr>
                            <td class="td_f12" width="100%" style="padding-top:50px;">
                                ${ o.employee_id.name or '_'}</br>
                                ${ o.employee_id.address_home_id.street or '' }</br>
                                ${ o.employee_id.address_home_id.city or '' }&nbsp;${ o.employee_id.address_home_id.zip or '' }</br>
                                ${ o.employee_id.address_home_id.country_id.name or '' }</br>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </br>
        <table class="tr_border">
            <tr>
                 <td width="50%">
                    <b>DESIGNATION</b>
                </td>
                <td width="8%">
                  <b>QUANTITE / BASE</b>
                </td>
                <td width="9%">
                  <b>TAUX</b>
                </td>
                <td width="8%">
                  <b>MONTANT</b>
                </td>
                <td width="15%" colspan="2">
                  <b>CHARGES PATRONALES</b>
                </td>
            </tr>
        %for p in get_payslip_lines(o.line_ids):
            <tr>
              <td width="50%" align="left">
                ${ p.code or '' } ${ p.name or '' }
              </td>
              <td width="8%">
                %if p.amount_select <> 'fix' and p.amount_select <> 'percentage' or  '' :
                    %if p.amount_select== 'percentage' or  '':
                          ${ p.amount or '' }
                    %endif
                    %if p.amount_select== 'fix' or  '':
                        ${ p.quantity or '' }
                    %endif
                %endif
              </td>
              <td width="9%">
                %if p.amount_select <> 'percentage' or  '':
                    %if p.amount_select == 'percentage' or  '':
                          ${  p.rate or '' }
                    %endif
                %endif
              </td>
              <td width="8%">
                 ${ p.total or '' }
              </td>
              <td >
                 ${ get_employer_line(o, p) and get_employer_line(o, p).rate or ''}
              </td>
              <td >
                ${ get_employer_line(o,p) and get_employer_line(o,p).total or '' }
              </td>
            </tr>
           %endfor
        </table>
       </br>
        <table width="100%" class="tr_border">
            <tr>
                    <td style="border: 0px;text-align:left;font-weight: bold; font-size:10px; width:"40% ; " colspan="4">
                      Mode de reglement : ${ o.payment_mode or '' }</br>
                      Paye le :
                    </td>
                    <td style="border-bottom: 0px;"><b>
                      NET A PAYER </b>
                    </td>
                    <td style="border-bottom: 0px;"><b>
                      TOTAL CHARGES PATRONALES</b> 
                    </td>
                  </tr>
                  <tr>
                    <td style="border: 0px;text-align:left;font-weight: bold; font-size:10px;padding-top:0px " width="40%" colspan="4">
                      Conv. Coll.: ${ o.employee_id.company_id.conv_coll or '' }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                      ${ get_total_by_rule_category(o, 'NET') }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                      ${ get_total_by_rule_category(o, 'COMP') }
                </td>
            </tr>
             <tr>
                <td width="16%" style="padding-top:0px;border-bottom: 0px">
                  <b>SALAIRE BRUT</b>
                </td>
                <td width="16%" style="padding-top:0px;border-bottom: 0px">
                  <b>TOTAL CHARGES SALARIALES</b>
                </td>
                <td width="16%" style="padding-top:0px;border-bottom: 0px">
                  <b>NET IMPOSABLE</b>
                </td>
                <td width="18%" style="padding-top:0px;border-bottom: 0px">
                  <b>PLAFOND S.S.</b>
                </td>
                <td width="16%" style="padding-top:0px;border-bottom: 0px">
                </td>
                <td width="18%" style="padding-top:0px;border-bottom: 0px">
                  <b>COUT GLOBAL SALARIE</b>
                </td>
              </tr>
              <tr>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                        ${ get_total_by_rule_category(o, 'BRUT') }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                        ${ get_total_by_rule_category(o, 'SALC') }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                      ${  get_total_by_rule_category(o, 'C_IMP') }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                        ${ o.employee_id.company_id.plafond_secu or '' }
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                    </td>
                    <td style="font-size:10px;text-align:right;paddind-bottom:0px;border-top: 0px;">
                      ${ get_total_by_rule_category(o, 'TOTAL') }
                    </td>
              </tr>
        </table>
        </br>
        </br>
        <p class="font">DANS VOTRE INTERET ET POUR VOUS AIDER A FAIRE VALOIR VOS DROITS, CONSERVEZ CE BULLETIN DE PAIE SANS LIMITATION DE DUREE</p>
     <p style="page-break-after:always"></p>
    %endfor
    
</body>
</html>