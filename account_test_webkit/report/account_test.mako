<html>
<head>
     <style type="text/css">
           .list_table2 {
                text-align:left;
                border-collapse: collapse;
            }
            .list_table2 td {
                border:1px solid black;
                border-collapse: collapse;
                font-family:"Times New Roman";
                font-size:12px;
                padding: 5px 5px 5px 5px; 
                }
           
        </style>
    <title>Account_Test.pdf</title>
</head>
<body>
<table width="100%" style="font-family: Times New Roman ;font-size:20px;">
    <tr>
        <td align="center">
            Accouting tests on ${ datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") }
        </td>
    </tr>
</table>
</br>
%for o in objects:
    <table width="100%" class="list_table2">
        <tr>
            <td>
               ${o.name} 
            </td>
        </tr>
        <tr>
            <td>
              <i>${ o.desc or '' }</i>
            </td>
        </tr>
    </table>
    <table width="100%" style="font-family: Times New Roman;font-size:12px;">
        %for test_result in execute_code(o.code_exec):
        <tr>
            <td>
                ${ test_result } 
            </td>
        </tr>
        %endfor  
    </table>
    </br>
%endfor
</body>
</html>