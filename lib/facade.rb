module Facade
  def direct_feed(args)
    xml = records_to_xml(args)
    feed(xml, args[:datasource_name])
  end

  def pretty_search(query, filters={})
    raw_results = search(query, filters)
    return raw_results if raw_results == GSA::NO_RESULTS
    pretty_search_results(raw_results)
  end

  def facet(search_results, facetables)
    GSA::Faceter.facet(search_results, facetables)
  end

  def uids_from_pretty_search(pretty_search_results, uid)
    GSA::UIDExtractor.extract(pretty_search_results, uid)
  end

  #########
  protected
  #########

  def feed(xml_file, datasource_name)
    GSA::Feeder.feed(xml_file, datasource_name)
  end

  def search(query, filters={})
    GSA::Searcher.search(query, filters)
  end

  def pretty_search_results(search_results)
    GSA::SearchConverter.convert(search_results)
  end

  def records_to_xml(args)
    GSA::RecordsConverter.convert(args)
  end
end
