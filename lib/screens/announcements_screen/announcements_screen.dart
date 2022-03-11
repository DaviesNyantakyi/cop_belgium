import 'package:cop_belgium/models/announcement_model.dart';
import 'package:cop_belgium/screens/announcements_screen/announcements_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Announcement> announcements = [
      Announcement(
          title:
              '"Pano" ontdekt salmonella in kippenworst: hoe verwerkt vlees de regels omzeilt en Belgische boeren bedreigt',
          dateTime: DateTime.now(),
          description:
              '''Hoe groot is de kans nu om een stukje gevogeltevlees te kopen dat besmet is? Voor een "Pano"-reportage over de pluimveesector die vanavond te zien is, deden we de test. De redactie nam contact op met twee labo's, en liet er in totaal 27 stalen onderzoeken. Het gaat om een breed assortiment: diepvriesvlees, gewone kipfilets en verwerkt vlees. Sommige van die producten waren eerder al eens werden teruggeroepen door het voedselagentschap FAVV. 

Wat blijkt? Een kippenworst uit het diepvriesassortiment van Aldi, bevat een salmonella-bacterie van het type Enteritidis, dat erg ziekmakend is voor de mens. In Europese voedselwetgeving is dat type bekend als een "te bestrijden type" salmonella. Het product werd eerder al eens teruggeroepen in 2020 en in 2021, maar ook al gaat dit om een nieuwe lading (een nieuw "lot") kippen, blijkbaar is de kippenworst nog steeds niet in orde. De worst bevat kippenvlees dat gekweekt en geslacht is in Polen, en verwerkt werd in België. '''),
      Announcement(
          title:
              'Regel van vier verdwijnt, enkel besmette en zieke kinderen moeten thuisblijven: deze nieuwe regels gelden op school',
          dateTime: DateTime.now().subtract(const Duration(days: 365)),
          description:
              '''De afgelopen dagen trok het onderwijsveld steeds luider aan de alarmbel. Meer en meer meer klassen en scholen moesten namelijk de deuren sluiten, waardoor ook veel niet-positieve leerlingen gedwongen thuis kwamen te zitten. Vlaams minister van Onderwijs Ben Weyts (N-VA) bevestigde dit in het Vlaams Parlement met de meest recente cijfers: er zijn momenteel 102 scholen in Vlaanderen gesloten door corona - 35 in het basisonderwijs, 67 in het secundair onderwijs. Vorige week waren er in totaal nog 19. 

En dus verzamelden de verschillende ministers van Onderwijs en Volksgezondheid van ons land opnieuw op een Interministeriële Conferentie Volksgezondheid (IMC). Het overleg werd ’s middags even onderbroken, maar uiteindelijk werd dan toch een akkoord bereikt.'''),
      Announcement(
          title:
              'Omikron heeft familie: wat weten we al over de nieuwe coronatelg BA.2?',
          dateTime: DateTime.now().subtract(const Duration(days: 7000)),
          description:
              '''Er zijn intussen al meldingen van BA.2 in meerdere landen, onder meer uit India, Singapore, de Verenigde Staten, het Verenigd Koninkrijk, Zweden en Denemarken. Denemarken is koploper, daar worden de meeste aantallen gemeld en zou BA.2 zelfs al de bovenhand hebben op omikron. Op zich is het niet verwonderlijk dat in Denemarken de meeste BA.2-gevallen vastgesteld worden, want dat land voert een uitgebreid en doorgedreven sequencing-beleid.

Hoe dan ook houdt de Wereldgezondheidsorganisatie (WHO) BA.2 in de gaten. Ze raadt aan dat overheden de eigenschappen van de variant goed in kaart brengen, om te bepalen of die een nieuwe uitdaging wordt voor een wereld intussen meer dan coronamoe is. "De BA.2-afstamming, die in een aantal mutaties verschilt van BA.1, is in verschillende landen in opmars"; schrijft de WHO. "Onderzoek naar de eigenschappen van BA.2, met daarbij ook zijn mogelijkheden om immuniteit te omzeilen en zijn ziekmakend effect, moet prioriteit krijgen, onafhankelijk van en in vergelijking met BA.1."

Het Britse gezondheidsagentschap UKHSA heeft BA.2 al geklasseerd als een variant under investigation, een variant om waakzaam voor te zijn.'''),
    ];

    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(kBodyPadding).copyWith(top: 20),
          separatorBuilder: (context, _) => const SizedBox(
            height: kContentSpacing12,
          ),
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            return Center(
              child: AnnouncementsCard(
                announcement: announcements[index],
                onPressed: () {
                  _showBottomSheet(
                    context: context,
                    announcement: announcements[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required Announcement announcement,
  }) {
    return showMyBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                announcement.title,
                style: kSFHeadLine3,
              ),
            ),
            const SizedBox(height: kContentSpacing12),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                FormalDates.formatEDmyyyyHm(date: announcement.dateTime),
                style: kSFCaption,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                announcement.description,
                style: kSFBody,
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      elevation: kAppbarElevation,
      title: const Text(
        'Announcements',
        style: kSFHeadLine3,
      ),
      leading: kBackButton(context: context),
    );
  }
}
