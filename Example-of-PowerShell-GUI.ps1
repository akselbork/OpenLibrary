


function Convert-XAMLtoWindow
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $XAML,
        
        [string[]]
        $NamedElements,
        
        [switch]
        $PassThru
    )
    
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms
    
    $reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
    $result = [System.Windows.Markup.XAMLReader]::Load($reader)
    foreach($Name in $NamedElements)
    {
        $result | Add-Member NoteProperty -Name $Name -Value $result.FindName($Name) -Force
    }
    
    if ($PassThru)
    {
        $result
    }
    else
    {
        $result.ShowDialog()
    }
}

$xaml = @'
<Window
   xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
   xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
   MinHeight="350"
   Width="525"
   SizeToContent="Height"
   Title="PowerShell WPF Window"
   Topmost="True">
   <Grid>
      <Grid.ColumnDefinitions>
         <ColumnDefinition Width="30*"/>
         <ColumnDefinition Width="30*"/>
         <ColumnDefinition Width="30*"/>
      </Grid.ColumnDefinitions>
      <Grid.RowDefinitions>
         <RowDefinition Height="20*"/>
         <RowDefinition Height="Auto"/>
         <RowDefinition Height="20*"/>
      </Grid.RowDefinitions>
      <TextBlock
         Name="TextMessage"
         Grid.Column="1"
         Grid.Row="1"
         HorizontalAlignment="Center"
         VerticalAlignment="Center"
         FontFamily="Consolas"
         FontSize="20"
         FontWeight="Bold"
         Foreground="Blue">Hello World
      </TextBlock>
      <Button
         Name="OK"
         Width="80"
         Height="25"
         Grid.Column="2"
         Grid.Row="2"
         HorizontalAlignment="Right"
         Margin="10"
         VerticalAlignment="Bottom">OK
      </Button>
   </Grid>
</Window>
'@

$window = Convert-XAMLtoWindow -XAML $xaml -NamedElements 'TextMessage', 'OK' -PassThru
$window.ok.add_click({
        $window.close()
    }
)


$window.ShowDialog()
