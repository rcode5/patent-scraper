module QueryFormHelper

  FIELD_MAP = {
    "TI"   => "Title",
    "ABTX" => "Abstract",
    "ISD"  => "Issue Date",
    "PN"   => "Patent Number",
    "APD"  => "Application Date",
    "AP"   => "Application Serial Number",
    "KD"   => "Application Type",
    "AANM" => "Applicant Name",
    "AACI" => "Applicant City",
    "AAST" => "Applicant State",
    "AACO" => "Applicant Country",
    "AAAT" => "Applicant Type",
    "ASNM" => "Assignee Name",
    "ASCI" => "Assignee City",
    "ASST" => "Assignee State",
    "ASCO" => "Assignee Country",
    "CIPC" => "International Classification",
    "CPC"  => "Current CPC Classification",
    "CPCL" => "Current CPC Classification Class",
    "ORCL" => "Current US Classification",
    "XP"   => "Primary Examiner",
    "XA"   => "Assistant Examiner",
    "INNM" => "Inventor Name",
    "INCI" => "Inventor City",
    "INST" => "Inventor State",
    "INCO" => "Inventor Country",
    "GOTX" => "Government Interest",
    "LREP" => "Attorney or Agent",
    "PARN" => "Parent Case Information",
    "PCTA" => "PCT Information",
    "PT3D" => "PCT 371C124 Date",
    "PTAD" => "PCT Filing Date",
    "PRFR" => "Foreign Priority",
    "REIS" => "Reissue Data",
    "RPAF" => "Reissued Patent Application Filing Date",
    "RLAP" => "Related US App. Data",
    "RLFD" => "Related Application Filing Date",
    "PRAD" => "Priority Claims Date",
    "PPPD" => "Prior Published Document Date",
    "UREF" => "Referenced By",
    "FREF" => "Foreign References",
    "OREF" => "Other References",
    "ACLM" => "Claim(s)",
    "PPDB" => "Description/Specification",
    "FMID" => "Patent Family ID",
    "AFFF" => "130(b) Affirmation Flag",
    "AFFT" => "130(b) Affirmation Statement",
    "COFC" => "Certificate of Correction",
    "PTC"  => "PTAB Trial Certificate",
    "REEX" => "Re-Examination Certificate",
    "SEC"  => "Supplemental Exam Certificate",
    "ILRN" => "International Registration Number",
    "ILRD" => "International Registration Date",
    "ILFD" => "Hague International Filing Date",
    "ILPD" => "International Registration Publication Date"
  }

  def term_input(label:, id:, name:)
    capture do
      concat(content_tag :label, label, for: id, class: 'control-label')
      concat(tag :input, for: id, name: name, class: 'form-control')
    end
  end

  def field_selector(label:, id:, name:, selected: nil)

    options = [content_tag(:option, "All", value: nil)]
    options << FIELD_MAP.map do |value, display|
      opts = { value: value }
      content_tag :option, display, opts
    end
    
    capture do
      concat(content_tag :label, label, for: id, class: 'control-label')
      concat(content_tag :select, options.join.html_safe, name: name, class: 'form-control')
    end
  end
  

end

