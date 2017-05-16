//
//  MSAgent+Convertible.swift
//  MoyskladNew
//
//  Created by Anton Efimenko on 28.10.16.
//  Copyright © 2016 Andrey Parshakov. All rights reserved.
//

import Foundation

extension MSAgent : DictConvertable {
	public static func from(dict: Dictionary<String, Any>) -> MSEntity<MSAgent>? {
		guard let meta = MSMeta.from(dict: dict.msValue("meta"), parent: dict) else {
			return nil
		}
		
		guard let name: String = dict.value("name"), name.characters.count > 0,
			let companyType = MSCompanyType(rawValue: dict.value("companyType") ?? ""),
			let group = MSGroup.from(dict: dict.msValue("group")) else {
				return MSEntity.meta(meta)
		}
        
		return MSEntity.entity(MSAgent(meta: meta,
		        id: MSID(dict: dict),
		        accountId: dict.value("accountId") ?? "",
		        owner: MSEmployee.from(dict: dict.msValue("owner")),
		        shared: dict.value("shared") ?? false,
		        group: group,
		        info: MSInfo(dict: dict),
		        code: dict.value("code"),
		        externalCode: dict.value("externalCode"),
		        archived: dict.value("archived"),
		        actualAddress: dict.value("actualAddress"),
		        companyType: companyType,
		        email: dict.value("email"),
		        phone: dict.value("phone"),
		        fax: dict.value("fax"),
		        legalTitle: dict.value("legalTitle"),
		        legalAddress: dict.value("legalAddress"),
		        inn: dict.value("inn"),
		        kpp: dict.value("kpp"),
		        ogrn: dict.value("ogrn"),
		        ogrnip: dict.value("ogrnip"),
		        okpo: dict.value("okpo"),
		        certificateNumber: dict.value("certificateNumber"),
		        certificateDate: Date.fromMSDate(dict.value("") ?? ""),
		        accounts: dict.msValue("accounts").msArray("rows").map { MSAccount.from(dict: $0) }.flatMap { $0 },
		        agentInfo: MSAgentInfo.from(dict: dict)))
	}
}

extension MSAgentInfo {
	public func dictionary() -> Dictionary<String, Any> {
		return [String:Any]()
	}
	
	public static func from(dict: Dictionary<String, Any>) -> MSAgentInfo {
		return MSAgentInfo(isEgaisEnable: dict.value("isEgaisEnable"),
		                   fsrarId: dict.value("fsrarId"),
		                   payerVat: dict.value("payerVat") ?? false,
		                   utmUrl: dict.value("utmUrl"),
		                   director: dict.value("director"),
		                   chiefAccountant: dict.value("chiefAccountant"),
		                   tags: dict.value("tags") ?? [],
		                   contactpersons: nil, 
		                   discounts: nil,
		                   state: MSState.from(dict: dict.msValue("state")))
	}
}
