Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6E16B203
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 22:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgBXVTM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 16:19:12 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17365 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVTM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Feb 2020 16:19:12 -0500
Received: from [172.30.220.169] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1582579148004574.4226094170849; Mon, 24 Feb 2020 22:19:08 +0100 (CET)
Subject: Re: [PATCH] imsm: Remove --dump/--restore implementation
To:     Blazej Kucman <blazej.kucman@intel.com>, linux-raid@vger.kernel.org
References: <20200219101317.30293-1-blazej.kucman@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <6363ae32-2a94-7519-f099-ffe69007ed12@trained-monkey.org>
Date:   Mon, 24 Feb 2020 16:19:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219101317.30293-1-blazej.kucman@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/19/20 5:13 AM, Blazej Kucman wrote:
> Functionalities --dump and --restore are not supported.
> Remove dead code from imsm.
> 
> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>

Applied!

Thanks,
Jes

