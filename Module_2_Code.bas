VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub Stock_Analyis()

        Dim ws As Worksheet
        Dim totalrow As Long
        Dim LastRow As Long
        Dim firstmonth As Long
        Dim vol As LongLong
        Dim openval As Double
        Dim closeval As Double
        
        For Each ws In ThisWorkbook.Worksheets
        
                totalrow = 2
                LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
                firstmonth = 2
                
                For i = 2 To LastRow
                        
                        openval = ws.Cells(firstmonth, 3).Value
                        closeval = ws.Cells(i, 6).Value
                        vol = vol + ws.Cells(i, 7).Value
                        
                        ' 4 Result Columns
                        ws.Cells(totalrow, 9).Value = ws.Cells(i, 1).Value
                        ws.Cells(totalrow, 10).Value = closeval - openval
                        ws.Cells(totalrow, 11).Value = (closeval - openval) / openval
                        ws.Cells(totalrow, 12).Value = vol
                        
                        ' Greatest % increase
                        If ws.Cells(totalrow, 11).Value > ws.Cells(2, 17).Value Then
                                ws.Cells(2, 17).Value = ws.Cells(totalrow, 11).Value
                                ws.Cells(2, 16).Value = ws.Cells(totalrow, 9).Value
                        End If
                        
                        ' Greatest % decrease
                        If ws.Cells(totalrow, 11).Value < ws.Cells(3, 17).Value Then
                                ws.Cells(3, 17).Value = ws.Cells(totalrow, 11).Value
                                ws.Cells(3, 16).Value = ws.Cells(totalrow, 9).Value
                        End If
                        
                        ' Greatest Total Volume
                        If ws.Cells(totalrow, 12).Value > ws.Cells(4, 17).Value Then
                                ws.Cells(4, 17).Value = ws.Cells(totalrow, 12).Value
                                ws.Cells(4, 16).Value = ws.Cells(totalrow, 9).Value
                        End If
                        
                        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                        
                                totalrow = totalrow + 1
                                firstmonth = i + 1
                                vol = 0
                                
                        End If
                    
                Next i
                
                ' Color Green vs Red, Positive vs Negative
                For j = 2 To LastRow
                        
                        If ws.Cells(j, 10).Value > 0 Then
                                ws.Cells(j, 10).Interior.ColorIndex = 4
                        ElseIf ws.Cells(j, 10).Value < 0 Then
                                ws.Cells(j, 10).Interior.ColorIndex = 3
                        End If
                        
                        If ws.Cells(j, 11).Value > 0 Then
                                ws.Cells(j, 11).Interior.ColorIndex = 4
                        ElseIf ws.Cells(j, 11).Value < 0 Then
                                ws.Cells(j, 11).Interior.ColorIndex = 3
                        End If
                        
                Next j
                
        Next ws

End Sub
