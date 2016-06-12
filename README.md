# CampaignFinanceApp
CamPaignFiannceApp for Shiny Apps
Instructions & Documentation","Instructions for the Camapign Finance app: 
                                            The app was constructed with data taken from (http://www.opensecrets.org/pres16).
                                            By checking the tickboxs an analyst can include/exclude a candidate.
                                            It is possible to view analysis by candidate and by party (using selected candidates) in pLots tab.
                                            Also it is possible to look at the detailed table information in long form in Summary tab.
                                            
                                            The application was built with shiny and uses dplyr and ggplot to analyze the data and rvest to scrape the data.

                                            The checkbox inputs on the server affect the reactive output which then based on these inputs (Candidate or Donation type) is then aggregated accordingly using dplyr (the server calculations). Then the results are plotted using ggplot and the plot returned to the UI as a server output.
