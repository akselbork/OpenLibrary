cls

    TRY {
        IF (Get-Variable xaml -ErrorAction SilentlyContinue) { 
            TRY {
                Remove-Variable xaml -ErrorAction SilentlyContinue
                Write-Verbose "Variable `$XAML has been removed"
            } CATCH {
                Write-Verbose "Variable `$XAML cannot be removed, it does not exist"
            }
        } 
    } CATCH {
    
    }

    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')


$XAML = @"
<Window x:Class="WpfApplication1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication1"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525" ShowInTaskbar="True" WindowStyle="None">
    <Grid>
        <Label x:Name="label" Content="USERNAME" HorizontalAlignment="Left" Margin="20,20,0,0" VerticalAlignment="Top" Width="350" FontSize="20"/>
        <TextBox x:Name="textBox" HorizontalAlignment="Left" Height="25" Margin="20,100,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="360
                    " VerticalContentAlignment="Center" ForceCursor="True"/>
        <Button x:Name="button" Content="SEARCH" HorizontalAlignment="Left" Margin="400,100,0,0" VerticalAlignment="Top" Width="100" Height="25"/>
        <Label x:Name="label1" Content="Skriv det brugernavn i feltet nedenfor og tryk SØG, og få computeren du benytter mest"
                Margin="20,48,0,0" VerticalAlignment="Top" Width="480" Height="40" FontSize="10.667" HorizontalAlignment="Left"/>
        <ListView x:Name="listView" HorizontalAlignment="Left" Height="137" Margin="20,142,0,0" VerticalAlignment="Top" Width="480">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="Last Used" Width="150"></GridViewColumn>
                    <GridViewColumn Header="Computername" Width="230"></GridViewColumn>
                    <GridViewColumn Header="Active" Width="100"></GridViewColumn>
                </GridView>
            </ListView.View>
        </ListView>
        <Button x:Name="button1" Content="OK" HorizontalAlignment="Left" Margin="400,300,0,0" VerticalAlignment="Top" Width="100"/>
        <Button x:Name="button2" Content="CANCEL" HorizontalAlignment="Left" Margin="280,300,0,0" VerticalAlignment="Top" Width="100"/>
    </Grid>
</Window>
"@

    [xml]$XAML = $XAML -replace 'xmlns:d=.+','' -replace 'xmlns:mc=.+','' -replace 'xmlns:local=.+','' -replace 'mc:Ignorable="d"','' -replace 'x:N','N'  -replace '^<Win.*', '<Window'

    #Read XAML
<#    $reader=(New-Object System.Xml.XmlNodeReader $xaml) 
    try {
        $Form=[Windows.Markup.XamlReader]::Load( $reader )
    } catch {
        Write-Host 'Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered.'; exit
    }
#>
    #===========================================================================
    # Store Form Objects In PowerShell
    #===========================================================================

    $test = $xaml.SelectNodes('//*[@Name]')
    $test.name

    $xaml.SelectNodes('//*[@Name]') | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}