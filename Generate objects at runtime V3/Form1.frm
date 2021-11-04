VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "GUI objects at runtime"
   ClientHeight    =   10425
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   15105
   LinkTopic       =   "Form1"
   ScaleHeight     =   695
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   1007
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox kval 
      Height          =   285
      Left            =   7320
      TabIndex        =   11
      Text            =   "2"
      Top             =   1560
      Width           =   615
   End
   Begin VB.TextBox Re 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      Height          =   285
      Index           =   0
      Left            =   11520
      TabIndex        =   10
      Text            =   "0"
      Top             =   120
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.TextBox V 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0E0FF&
      Height          =   285
      Index           =   0
      Left            =   10920
      TabIndex        =   9
      Text            =   "0"
      Top             =   120
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Frame Frame2 
      Caption         =   "Option"
      Height          =   1935
      Left            =   7080
      TabIndex        =   7
      Top             =   120
      Width           =   2535
      Begin VB.CommandButton Calc_k_states 
         Caption         =   "Do something"
         Height          =   495
         Left            =   120
         TabIndex        =   12
         Top             =   720
         Width           =   2055
      End
      Begin VB.CheckBox RND_Values 
         Caption         =   "Fill random values"
         Height          =   255
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Value           =   1  'Checked
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "times"
         Height          =   255
         Left            =   960
         TabIndex        =   13
         Top             =   1440
         Width           =   1095
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Parameters"
      Height          =   1935
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   6855
      Begin VB.HScrollBar square_M 
         Height          =   255
         Left            =   240
         Max             =   20
         Min             =   1
         TabIndex        =   6
         Top             =   1200
         Value           =   1
         Width           =   5175
      End
      Begin VB.HScrollBar HScroll1 
         Height          =   255
         Left            =   240
         Max             =   20
         Min             =   1
         TabIndex        =   3
         Top             =   480
         Value           =   1
         Width           =   5175
      End
      Begin VB.HScrollBar HScroll2 
         Height          =   255
         Left            =   240
         Max             =   20
         Min             =   1
         TabIndex        =   2
         Top             =   840
         Value           =   1
         Width           =   5175
      End
      Begin VB.Label MY_ROW 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         Height          =   255
         Left            =   5520
         TabIndex        =   5
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label MX_COL 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         Height          =   255
         Left            =   5520
         TabIndex        =   4
         Top             =   480
         Width           =   1095
      End
   End
   Begin VB.Timer Real_time_matrix 
      Interval        =   10
      Left            =   9720
      Top             =   120
   End
   Begin VB.TextBox M 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0FF&
      Height          =   285
      Index           =   0
      Left            =   10320
      TabIndex        =   0
      Text            =   "0"
      Top             =   120
      Visible         =   0   'False
      Width           =   495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'   ________________________________                          ____________________
'  /            Matrix              \________________________/       v1.00        |
' |                                                                               |
' |            Name:  Matrix V1.0                                                 |
' |        Category:  Open source software                                        |
' |          Author:  Paul A. Gagniuc                                             |
' |           Email:  paul_gagniuc@acad.ro                                        |
' |  ____________________________________________________________________________ |
' |                                                                               |
' |    Date Created:  September 2008                                              |
' |       Tested On:  WinXP, WinVista, Win7, Win8                                 |
' |             Use:  generate objects at runtime                                  |
' |                                                                               |
' |                  _____________________________                                |
' |_________________/                             \_______________________________|
'

Option Explicit


Dim Old_HSX As Integer
Dim Old_HSY As Integer

Dim MX_pos As Variant
Dim MY_pos As Variant

Dim space_x As Integer
Dim space_y As Integer


Private Sub Form_Load()
    MX_pos = 10
    MY_pos = 120
    
    space_x = 3
    space_y = 3
    
    'Calc_k_states.Caption = "I did " & kval.Text & " times"
End Sub



Function Load_V(ByVal X As Integer)

    Dim c, i, MYY As Integer
    Dim xx, yy, Exact As Variant
    
    For i = 1 To V.UBound
        Unload V(i)
    Next i
        
        For c = 1 To X
    
            Load V(c)
            
            MYY = HScroll2.Value + square_M.Value
            Exact = ((M(0).Height + space_y) * (MYY + 1))
            
            xx = MX_pos + ((V(0).Width + space_x) * c)
            yy = MY_pos + (Exact / 2)
    
            V(c).Move xx, yy
            V(c).Visible = True
    
            If RND_Values.Value = 1 Then V(c).Text = Round(Rnd(10), 2)
    
            V(c).Refresh
    
        Next c

End Function


Function Load_M(ByVal X As Integer, ByVal Y As Integer)

    Dim c, r, a, i, MXX As Integer
    Dim xx, yy, Exact As Variant
    
    For i = 1 To M.UBound
        Unload M(i)
    Next i
    
    a = 0
    
    For r = 1 To Y
        
        For c = 1 To X
    
            a = a + 1
    
            Load M(a)
            
            MXX = HScroll1.Value + square_M.Value
            Exact = ((V(0).Width + space_x) * (MXX + 1))
            
            xx = MX_pos + Exact + ((M(0).Width + space_x) * c)
            yy = MY_pos + ((M(0).Height + space_y) * r)
    
            M(a).Move xx, yy
            M(a).Visible = True
            If RND_Values.Value = 1 Then M(a).Text = Round(Rnd(10), 2)
            M(a).Refresh
    
        Next c
    
    Next r
    
End Function


Function Load_R(ByVal X As Integer)

    Dim c, i, MYY, MXX As Integer
    Dim xx, yy, Exact, ExactM As Variant
    
    For i = 1 To Re.UBound
        Unload Re(i)
    Next i
        
        For c = 1 To X
    
            Load Re(c)
            
            MYY = HScroll2.Value + square_M.Value
            Exact = ((M(0).Height + space_y) * (MYY + 1))
            
            
            MXX = HScroll1.Value + square_M.Value
            ExactM = ((M(0).Width + space_x) * (MXX + 1))
            
            
            xx = MX_pos + (ExactM * 2) + ((Re(0).Width + space_x) * c)
            yy = MY_pos + (Exact / 2)
    
            Re(c).Move xx, yy
            Re(c).Visible = True
            Re(c).Refresh
    
        Next c

End Function


Private Sub Calc_k_states_Click()

    Dim i, j, a, ks As Integer
    
    ks = kval.Text
    
    For i = 1 To ks
    
    ONE_K_STATE
    
        For j = 1 To V.UBound
    
            V(j).Text = Re(j).Text
    
        Next j
    
    Next i
End Sub


Private Sub ONE_K_STATE()

    Dim i, j, a, d, MXX, MYY As Integer
    Dim tmp, Vector As Variant
        
    MXX = HScroll1.Value + square_M.Value
    MYY = HScroll2.Value + square_M.Value
    
    If MXX <> MYY Then
        MsgBox "This is not square matrix !"
        Exit Sub
    End If
    
    a = 0
    
    For i = 1 To M.UBound Step MXX
    d = d + 1
    Vector = 0
    
        For j = 1 To MXX
     
            a = a + 1
            tmp = (Val(V(j).Text) * Val(M(a).Text))
            Vector = Vector + tmp
    
    
        Next j
    
        Re(d).Text = Vector
    
    Next i
    
End Sub

Private Sub Real_time_matrix_Timer()

    Dim MXX, MYY As Integer
    
    MXX = HScroll1.Value + square_M.Value
    MYY = HScroll2.Value + square_M.Value
    
    If Old_HSX <> MXX Or Old_HSY <> MYY Then
        Call Load_V(MXX)
        Call Load_M(MXX, MYY)
        Call Load_R(MXX)
        
        Old_HSX = MXX
        Old_HSY = MYY
        
        MX_COL.Caption = Old_HSX & " cols"
        MY_ROW.Caption = Old_HSY & " rows"
    End If

End Sub


Private Sub kval_Change()
    Calc_k_states.Caption = "I did " & kval.Text & " times"
End Sub
